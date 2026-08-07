## 2026-08-07 - [PowerShell N+1 Process Optimizations]
**Learning:** [PowerShell invokes external native commands like `git` as new child processes. Calling native commands inside loops like `ForEach-Object` causes a massive performance hit due to N+1 process spawn overhead. However, PowerShell automatically expands arrays passed to native commands into separate arguments, allowing you to batch operations safely and easily.]
**Action:** [Use pipeline assignment to gather data into arrays, then pass the array as a single batched argument to native commands instead of looping.]
