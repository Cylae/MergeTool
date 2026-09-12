## 2025-05-18 - Batch Local Git Branch Deletion in PowerShell

**Learning:** Iterating over local git branches and invoking `git branch -D` for each branch inside a `ForEach-Object` loop causes significant process spawning overhead (N+1 invocations). Batching branch names into an array and passing them to a single `git branch -D` invocation dramatically reduces execution time.

**Action:** Whenever deleting multiple git branches or running repetitive CLI operations in PowerShell, collect arguments into an array and pass them in a single batch call.
