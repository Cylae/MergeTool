## 2026-10-03 - Batch Local Branch Cleanup

**Learning:** Deleting local git branches sequentially inside a PowerShell `ForEach-Object` loop introduces process spawning overhead (N+1 executable calls). Passing an array of branch names directly to a single `git branch -D` invocation batches the operation into a single process execution.

**Action:** Replace `git branch | ForEach-Object { git branch -D $_ }` with `$branchesToDelete = @(git branch | ForEach-Object { ... }); git branch -D $branchesToDelete` to eliminate N+1 process creation overhead.
