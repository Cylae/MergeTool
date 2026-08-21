## 2026-08-21 - [Optimize PowerShell N+1 process spawns]
**Learning:** Calling native executables (like `git`) inside a PowerShell `ForEach-Object` loop incurs significant O(N) subprocess creation overhead, which is exceptionally slow on Windows/PowerShell environments.
**Action:** Always collect items into an array first and pass the entire array to the native executable in a single call. PowerShell automatically expands arrays into separate arguments (e.g., `git branch -D $branches`), reducing the operation to O(1) process spawns.
