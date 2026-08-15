## 2024-05-18 - Batching Git Commands in PowerShell
**Learning:** In PowerShell scripts, running native executables (like `git`) inside loops (e.g., `ForEach-Object`) causes N+1 process spawning overhead. PowerShell automatically expands arrays passed to native commands into separate arguments, making batching trivial.
**Action:** Always batch arguments for native executables by passing arrays directly to the command instead of looping over the array and calling the command for each item.
