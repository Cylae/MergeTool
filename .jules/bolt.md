## 2026-10-15 - Batch branch deletion in git cleanup

**Learning:** In PowerShell, invoking native executables like `git` inside a loop (`ForEach-Object`) creates substantial subprocess creation overhead (N+1 execution pattern). Passing an array of arguments to `git branch -D` batches the operations into a single execution.

**Action:** Whenever performing bulk operations on native CLI commands, collect arguments into a PowerShell array and pass them in a single batch invocation instead of iterating in a loop.
