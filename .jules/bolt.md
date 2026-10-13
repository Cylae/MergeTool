## 2025-05-18 - Batching Git branch deletions in PowerShell
**Learning:** Calling `git branch -D` inside `ForEach-Object` for every local branch creates N+1 process creation overhead.
**Action:** Collect branch names into an array and pass the array to a single `git branch -D` call, allowing PowerShell to expand arguments into a single native process invocation.
