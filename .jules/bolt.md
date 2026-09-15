## 2025-05-18 - Batch Local Branch Cleanup

**Learning:** Deleting local git branches sequentially in a loop using `git branch -D` incurs N+1 process spawning overhead. Batching branch names into an array and executing a single `git branch -D` call significantly improves execution speed.

**Action:** Whenever performing cleanup or bulk operations on git entities (branches, tags, etc.) in PowerShell or shell scripts, collect target identifiers into a list and invoke git once with batched arguments instead of iterating with `ForEach-Object`.
