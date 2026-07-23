<#
.SYNOPSIS
    Merge automatique de toutes les PR ouvertes, avec resolution de conflits.

.DESCRIPTION
    Pour chaque PR non-draft :
      1. Tente le merge direct (gh pr merge --admin).
      2. Si conflit : checkout la branche de la PR, merge main dedans avec
         resolution auto (-X ours/theirs), push, puis retente le merge.
    Log tout dans un CSV, nettoie les branches locales a la fin.

.PARAMETER Strategy
    "theirs" (defaut) : en cas de conflit, le code deja sur main est garde.
                         Sans risque : rien n'est ecrase, mais le contenu propre
                         a une PR peut ne pas passer sur les fichiers en conflit.
                         La PR est quand meme marquee "Merged".
    "ours"             : en cas de conflit, le code de la PR gagne.
                         Risque avec des PR qui se chevauchent : la derniere
                         traitee peut ecraser le fix d'une PR precedente sur
                         le meme fichier.

.PARAMETER DryRun
    N'execute rien, affiche juste ce qui serait tente pour chaque PR.

.PARAMETER BaseBranch
    Branche de base du repo (defaut : main).

.EXAMPLE
    .\Merge-AllPRs.ps1
    .\Merge-AllPRs.ps1 -Strategy ours
    .\Merge-AllPRs.ps1 -DryRun
#>

param(
    [ValidateSet("ours", "theirs")]
    [string]$Strategy = "theirs",
    [switch]$DryRun,
    [string]$BaseBranch = "main"
)

$ErrorActionPreference = "Stop"
$timestamp  = Get-Date -Format "yyyyMMdd_HHmmss"
$logFile    = "merge_log_$timestamp.csv"
$failedFile = "failed_prs_$timestamp.txt"
$results    = [System.Collections.Generic.List[object]]::new()

# --- Verifications prealables ------------------------------------------------
if (-not (Test-Path ".git")) {
    Write-Host "Erreur : ce dossier n'est pas un repo git." -ForegroundColor Red
    exit 1
}
gh auth status 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Host "Erreur : gh n'est pas authentifie (gh auth login)." -ForegroundColor Red
    exit 1
}

# --- Fonctions -----------------------------------------------------------------
function Invoke-GhMerge {
    param($Number, $MaxRetries = 2)
    for ($attempt = 1; $attempt -le $MaxRetries; $attempt++) {
        $output = gh pr merge $Number --merge --delete-branch --admin 2>&1
        if ($LASTEXITCODE -eq 0) { return $true }
        if ($output -match "rate limit|abuse") {
            Write-Host "  (limite de taux detectee, pause 30s...)" -ForegroundColor DarkGray
            Start-Sleep -Seconds 30
            continue
        }
        return $false
    }
    return $false
}

function Resolve-AndUpdate {
    param($Number, $Strategy)

    gh pr checkout $Number 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { return "checkout-failed" }

    git fetch origin $BaseBranch 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { return "fetch-main-failed" }

    git merge "origin/$BaseBranch" -X $Strategy --no-ff -m "Auto-merge $BaseBranch into PR #$Number (strategy: $Strategy)" 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) {
        git merge --abort 2>&1 | Out-Null
        return "merge-conflict"
    }

    git push 2>&1 | Out-Null
    if ($LASTEXITCODE -ne 0) { return "push-failed" }

    return "ok"
}

# --- Recuperation des PR -------------------------------------------------------
Write-Host "=== Recuperation des PR ouvertes ===" -ForegroundColor Cyan
try {
    $prs = @(gh pr list --state open --json number,title,isDraft,headRefName --limit 1000 | ConvertFrom-Json)
} catch {
    Write-Host "Erreur lors de la recuperation des PR : $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
if ($prs.Count -eq 0) {
    Write-Host "Aucune PR ouverte trouvee." -ForegroundColor Yellow
    exit 0
}
$prs = $prs | Sort-Object number

Write-Host "$($prs.Count) PR trouvees. Strategie de conflit : $Strategy" -ForegroundColor Cyan
if ($DryRun) { Write-Host "MODE DRY RUN : rien ne sera modifie.`n" -ForegroundColor Magenta } else { Write-Host "" }

git checkout $BaseBranch --force 2>&1 | Out-Null

# --- Boucle principale ----------------------------------------------------------
$ok = 0; $okResolved = 0; $fail = 0; $skip = 0
$i = 0

foreach ($pr in $prs) {
    $i++
    $prefix = "[$i/$($prs.Count)] PR #$($pr.number)"

    if ($pr.isDraft) {
        Write-Host "$prefix : draft, ignoree" -ForegroundColor Yellow
        $results.Add([pscustomobject]@{ Number = $pr.number; Title = $pr.title; Status = "Skipped-Draft"; Notes = ""; Time = Get-Date })
        $skip++
        continue
    }

    if ($DryRun) {
        Write-Host "$prefix : [DRY RUN] tenterait merge direct, puis resolution si conflit" -ForegroundColor DarkGray
        continue
    }

    try {
        if (Invoke-GhMerge -Number $pr.number) {
            Write-Host "$prefix : mergee (direct)" -ForegroundColor Green
            $results.Add([pscustomobject]@{ Number = $pr.number; Title = $pr.title; Status = "Merged"; Notes = "direct"; Time = Get-Date })
            $ok++
        }
        else {
            Write-Host "$prefix : conflit, resolution auto ($Strategy)..." -ForegroundColor DarkYellow
            $resolveResult = Resolve-AndUpdate -Number $pr.number -Strategy $Strategy

            if ($resolveResult -eq "ok") {
                if (Invoke-GhMerge -Number $pr.number) {
                    Write-Host "$prefix : mergee (conflit resolu)" -ForegroundColor Green
                    $results.Add([pscustomobject]@{ Number = $pr.number; Title = $pr.title; Status = "Merged"; Notes = "conflit resolu"; Time = Get-Date })
                    $okResolved++
                }
                else {
                    Write-Host "$prefix : echec meme apres resolution" -ForegroundColor Red
                    $results.Add([pscustomobject]@{ Number = $pr.number; Title = $pr.title; Status = "Failed"; Notes = "echec apres resolution"; Time = Get-Date })
                    $fail++
                }
            }
            else {
                Write-Host "$prefix : echec resolution ($resolveResult)" -ForegroundColor Red
                $results.Add([pscustomobject]@{ Number = $pr.number; Title = $pr.title; Status = "Failed"; Notes = $resolveResult; Time = Get-Date })
                $fail++
            }
        }
    }
    catch {
        Write-Host "$prefix : erreur inattendue - $($_.Exception.Message)" -ForegroundColor Red
        $results.Add([pscustomobject]@{ Number = $pr.number; Title = $pr.title; Status = "Error"; Notes = $_.Exception.Message; Time = Get-Date })
        $fail++
        git merge --abort 2>&1 | Out-Null
    }

    git checkout $BaseBranch --force 2>&1 | Out-Null
    Start-Sleep -Milliseconds 300
}

# --- Nettoyage des branches locales restantes ------------------------------------
if (-not $DryRun) {
    # ⚡ Bolt: Batch branch deletion to avoid N+1 process spawning overhead
    $branchesToDelete = git branch | ForEach-Object {
        $_.Trim("* ").Trim()
    } | Where-Object {
        $_ -and $_ -ne $BaseBranch
    }

    if ($branchesToDelete) {
        git branch -D $branchesToDelete 2>&1 | Out-Null
    }
}

# --- Resume -----------------------------------------------------------------------
if (-not $DryRun) {
    $results | Export-Csv -Path $logFile -NoTypeInformation -Encoding UTF8
    $results | Where-Object { $_.Status -eq "Failed" -or $_.Status -eq "Error" } |
        ForEach-Object { "#$($_.Number) - $($_.Title) - $($_.Notes)" } |
        Out-File $failedFile -Encoding UTF8
}

Write-Host "`n=== Resume ===" -ForegroundColor Cyan
Write-Host "Mergees direct    : $ok" -ForegroundColor Green
Write-Host "Mergees apres fix : $okResolved" -ForegroundColor Green
Write-Host "Echecs            : $fail" -ForegroundColor Red
Write-Host "Drafts ignorees   : $skip" -ForegroundColor Yellow

if (-not $DryRun) {
    Write-Host "`nLog complet : $logFile"
    if ($fail -gt 0) { Write-Host "PR en echec : $failedFile" -ForegroundColor Red }
}
