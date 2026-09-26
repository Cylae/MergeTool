## 2025-05-18 - Batch local branch deletion in `script.ps1`
**Learning:** Calling `git branch -D` inside a `ForEach-Object` loop introduces N+1 process spawning overhead. Collecting branch names into an array `@(...)` and passing them directly to a single `git branch -D` invocation dramatically speeds up cleanup operations.
**Action:** Always batch arguments for native CLI tools like `git` when operating on multiple items in PowerShell scripts.
