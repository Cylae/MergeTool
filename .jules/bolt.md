## 2025-05-18 - Batch git branch deletion in PowerShell

**Learning:** Invoking `git branch -D` individually inside a `ForEach-Object` loop introduces significant process spawning overhead (N+1 CLI invocations). Passing an array of branch names directly to a single `git branch -D` command allows PowerShell to expand arguments and execute deletion in a single process invocation.

**Action:** Whenever performing bulk operations with native CLI executables in PowerShell (e.g., git branch, git rm), collect target names into an array and pass them in a single command invocation rather than iterating over items in a loop.
