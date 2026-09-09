## 2026-09-09 - Batch deletion of local Git branches in PowerShell

**Learning:** Calling native executables like `git` inside PowerShell loops (such as `ForEach-Object`) causes severe N+1 process spawning overhead. Collecting all items into a PowerShell array and passing the array directly to native executables allows native argument expansion (e.g. `git branch -D branch1 branch2`), reducing external process creation from O(N) to O(1).

**Action:** Whenever iterating over items to invoke a CLI command in PowerShell, collect the arguments into an array and batch the CLI call outside the loop.
