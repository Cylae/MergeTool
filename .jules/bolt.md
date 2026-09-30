## 2026-09-30 - Batch local branch deletion in script.ps1
**Learning:** Calling `git branch -D` inside a PowerShell `ForEach-Object` loop introduces process spawning overhead (N+1 execution) for each branch to be cleaned up. Batching the branch names into an array and passing them to a single `git branch -D` invocation avoids this overhead entirely.
**Action:** Always batch array arguments for native CLI tools in PowerShell scripts instead of executing them repeatedly inside pipelines or loops.
