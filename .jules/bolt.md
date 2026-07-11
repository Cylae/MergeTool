## 2024-03-24 - Avoiding N+1 native process spawning overhead in PowerShell scripts
**Learning:** Calling native executables (like `git`) inside a loop (e.g., `ForEach-Object`) in PowerShell incurs a significant overhead for each invocation due to process creation costs.
**Action:** Always batch arguments and execute the native tool once whenever possible (e.g., passing an array of branch names to `git branch -D` instead of looping over each branch).
