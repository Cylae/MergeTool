## 2024-05-24 - [Avoid N+1 process spawning in PowerShell loops]
**Learning:** Spawning native executables (like `git`) inside a PowerShell `ForEach-Object` loop creates significant N+1 overhead due to process creation time for each iteration. For instance, cleaning up 100 git branches sequentially takes nearly 3 seconds.
**Action:** Always batch arguments for native executables when iterating over lists in PowerShell, turning O(N) process spawns into O(1) by passing arrays directly to the native command (e.g., `git branch -D $branchesToDelete`).
