## 2025-05-18 - Batch Git Branch Deletion in PowerShell

**Learning:** Invoking `git branch -D` inside a `ForEach-Object` loop introduces significant process spawning overhead (N+1 CLI invocations). Passing an array of branch names to `git branch -D` in a single invocation allows Git to delete all target branches in one batch.

**Action:** In PowerShell scripts performing multi-branch cleanup, collect branch names into an array variable and pass the array directly to `git branch -D` instead of looping over each branch individually.
