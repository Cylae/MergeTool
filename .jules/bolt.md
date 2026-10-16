## 2026-10-16 - Batch git branch deletion in cleanup loop

**Learning:** Iterating through remaining local branches using `ForEach-Object` and executing `git branch -D` individually introduces significant N+1 process creation overhead. Passing an array of branch names directly to a single `git branch -D` command executes a single process and reduces cleanup execution time significantly (~56% speedup in local benchmark tests with 50 branches).

**Action:** Whenever invoking native command line utilities (such as `git`) in PowerShell loops, batch the arguments into an array and call the binary once instead of spawning a new process for each item.
