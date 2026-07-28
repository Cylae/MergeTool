## 2023-10-25 - Batch Native Command Executions in PowerShell
**Learning:** Invoking native executables like `git` inside loops (e.g., `ForEach-Object`) in PowerShell spawns a new process for each iteration, causing severe N+1 overhead, especially on Windows. PowerShell automatically expands arrays passed to native commands, allowing for efficient batching (e.g., `git branch -D $branchesToDelete`).
**Action:** Always fetch parameters into an array using pipeline assignments and pass the array to a single native command invocation to avoid N+1 process creation overhead.
