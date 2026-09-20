## 2025-05-18 - Batch git branch deletion in PowerShell

**Learning:** Invoking external processes like `git` inside PowerShell loops (e.g. `ForEach-Object`) incurs significant overhead per item due to process spawning. Passing an array of arguments to `git branch -D` batches the operation into a single process execution, dramatically improving performance.
**Action:** When deleting multiple branches or resources via native executables in PowerShell, collect arguments into an array and pass them all at once to the command.
