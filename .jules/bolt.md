## 2024-06-25 - Avoid N+1 process overhead in PowerShell
**Learning:** Calling native executables (like `git`) inside a loop (like `ForEach-Object`) in PowerShell creates massive overhead due to process spawning for every item.
**Action:** Always filter and collect items into an array first, then pass the array as a batched argument to the native executable if it supports multiple arguments (e.g., `git branch -D $branchesToDelete`).
