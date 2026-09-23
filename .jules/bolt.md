## 2026-09-23 - Batch branch deletions in PowerShell

**Learning:** In PowerShell scripts interacting with `git`, calling `git branch -D` inside a `ForEach-Object` loop introduces significant process spawning overhead (O(N) process creations). Batching branch names into an array and passing them to a single `git branch -D` call reduces process creation overhead to O(1).
**Action:** Replace iterative process invocation loops for batchable git commands with pipeline assignment and single array argument invocation.
