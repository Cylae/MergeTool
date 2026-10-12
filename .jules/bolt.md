## 2026-10-12 - Batch local branch deletion in git
**Learning:** Invoking native CLI executables like `git` inside PowerShell `ForEach-Object` loops introduces $O(N)$ process spawning overhead. Batching arguments into a single native command execution reduces this to $O(1)$.
**Action:** Replace `git branch | ForEach-Object { git branch -D $_ }` with `git branch --format="%(refname:short)"` and pass the array of branch names directly to a single `git branch -D $branchesToDelete` call.
