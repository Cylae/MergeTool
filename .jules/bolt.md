## 2023-10-24 - N+1 process spawning overhead in PowerShell scripts
**Learning:** Found an anti-pattern where external native executables (e.g., `git`) are called inside loops (`ForEach-Object`). This causes N+1 process spawning overhead.
**Action:** Always batch arguments for native executables in PowerShell. For example, instead of running `git branch -D` in a loop, collect all branch names into an array and pass the array to `git branch -D` once. PowerShell automatically expands arrays passed to native commands.
