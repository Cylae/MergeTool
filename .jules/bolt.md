## 2026-09-03 - [PowerShell Native Command Execution Penalty]
**Learning:** In PowerShell, invoking a native executable (like `git`) inside a loop (like `ForEach-Object`) creates significant N+1 process spawning overhead. For example, deleting 100 branches individually via `git branch -D` takes >2 seconds, while passing an array of 100 branch names to a single `git branch -D` call takes ~100ms.
**Action:** When calling native commands with multiple targets in PowerShell, always gather the targets into an array and pass the array to the command in a single invocation to batch the operation.
