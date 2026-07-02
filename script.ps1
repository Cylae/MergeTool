# ===== Configuration =====
$strategy = "theirs"  # "theirs" = garder le code de la PR, "ours" = garder main
$logFile = "merge-report-$(Get-Date -Format 'yyyyMMdd-HHmmss').csv"
$maxRetries = 5
$retryDelaySeconds = 3
$results = @()
$ok = 0; $fail = 0; $skip = 0
# ===== Récupération des PR =====
$prs = gh pr list --state open --json number,title,isDraft | ConvertFrom-Json
foreach ($pr in $prs) {
    if ($pr.isDraft) {
        Write-Host "PR #$($pr.number) : skip (draft)" -ForegroundColor DarkGray
        $results += [PSCustomObject]@{Number=$pr.number; Title=$pr.title; Status="skip-draft"}
        $skip++; continue
    }
    Write-Host "`n=== PR #$($pr.number) : $($pr.title) ===" -ForegroundColor Cyan
    # ---- Étape 1 : vérifier si déjà mergeable ----
    $mergeable = gh pr view $pr.number --json mergeable -q .mergeable
    if ($mergeable -eq "MERGEABLE") {
        gh pr merge $pr.number --merge --delete-branch --admin
        if ($LASTEXITCODE -eq 0) {
            Write-Host "PR #$($pr.number) : mergée directement" -ForegroundColor Green
            $results += [PSCustomObject]@{Number=$pr.number; Title=$pr.title; Status="merged-direct"}
            $ok++
        } else {
            Write-Host "PR #$($pr.number) : échec inattendu" -ForegroundColor Red
            $results += [PSCustomObject]@{Number=$pr.number; Title=$pr.title; Status="fail-direct"}
            $fail++
        }
        continue
    }
    # ---- Étape 2 : tenter résolution automatique de conflit ----
    gh pr checkout $pr.number 2>$null
    git fetch origin main 2>$null
    git merge origin/main -X $strategy --no-edit 2>$null
    if ($LASTEXITCODE -ne 0) {
        git merge --abort 2>$null
        Write-Host "PR #$($pr.number) : conflit non auto-résolvable" -ForegroundColor Red
        $results += [PSCustomObject]@{Number=$pr.number; Title=$pr.title; Status="skip-unresolvable"}
        $skip++
        continue
    }
    git push 2>$null
    # ---- Étape 3 : retry avec pause pour laisser GitHub recalculer le statut ----
    $mergedOk = $false
    for ($i = 0; $i -lt $maxRetries; $i++) {
        Start-Sleep -Seconds $retryDelaySeconds
        $status = gh pr view $pr.number --json mergeable -q .mergeable
        if ($status -eq "MERGEABLE") {
            gh pr merge $pr.number --merge --delete-branch --admin
            if ($LASTEXITCODE -eq 0) {
                $mergedOk = $true
                break
            }
        }
    }
    if ($mergedOk) {
        Write-Host "PR #$($pr.number) : conflit résolu ($strategy) et mergée" -ForegroundColor Green
        $results += [PSCustomObject]@{Number=$pr.number; Title=$pr.title; Status="merged-resolved"}
        $ok++
    } else {
        Write-Host "PR #$($pr.number) : résolu localement mais merge final échoué après $maxRetries tentatives" -ForegroundColor Yellow
        $results += [PSCustomObject]@{Number=$pr.number; Title=$pr.title; Status="fail-after-resolve"}
        $fail++
    }
    # petite pause entre PR pour laisser GitHub se stabiliser avant la suivante
    Start-Sleep -Seconds 2
}
# ===== Retour sur main et rapport final =====
git checkout main 2>$null
$results | Export-Csv -Path $logFile -NoTypeInformation -Encoding UTF8
Write-Host "`n===== RÉSUMÉ =====" -ForegroundColor Cyan
Write-Host "OK: $ok | Échecs: $fail | Skip: $skip" -ForegroundColor White
Write-Host "Rapport détaillé : $logFile" -ForegroundColor White
