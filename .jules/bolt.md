## 2025-05-18 - Batch Local Branch Deletion in PowerShell

**Learning:** Invoking native CLI executables (such as `git`) inside PowerShell pipeline loops (`ForEach-Object`) creates substantial process spawning overhead (N+1 execution penalty). Passing an array of arguments to native commands allows PowerShell to automatically pass them as multiple arguments in a single process execution.

**Action:** Whenever performing cleanup or operations on multiple items with external commands (e.g., `git branch -D`), collect items into an array using pipeline assignment `@(...)` and invoke the CLI once with the entire array.
