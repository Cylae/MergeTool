## 2025-05-18 - Batching Git Branch Deletion in PowerShell

**Learning:** Calling `git branch -D` inside a `ForEach-Object` loop introduces N+1 process spawning overhead, causing severe performance slowdowns when cleaning up many local branches.
**Action:** Collect branch names into an array and pass them all at once to a single `git branch -D` call.
