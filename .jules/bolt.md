## 2024-08-22 - PowerShell Native Command Execution Overhead
**Learning:** Calling native executables (like `git`) inside a PowerShell `ForEach-Object` loop introduces significant O(N) process spawning overhead.
**Action:** Always batch arguments into a PowerShell array and pass the array directly to the native command outside the loop. PowerShell will automatically expand the array into separate arguments (e.g., `git branch -D $branchesArray`), reducing execution to O(1) process spawns.
