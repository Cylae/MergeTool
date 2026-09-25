## 2025-03-06 - Batch branch cleanup in `script.ps1`
**Learning:** Calling native executables like `git` inside loops in PowerShell introduces $O(N)$ process spawning overhead. Git commands like `git branch -D` natively accept multiple branch arguments at once.
**Action:** Filter and collect branch names into a PowerShell array, then pass the array to `git branch -D` to batch deletion into a single process execution.
