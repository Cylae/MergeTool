## 2026-10-05 - Batching local branch deletion in PowerShell

**Learning:** Spawning a native executable (like `git branch -D`) repeatedly inside a PowerShell loop (`ForEach-Object`) introduces significant process creation overhead (N+1 spawns). Since `git branch -D` accepts multiple branch names as positional arguments, passing an array of branch names to `git branch -D` allows PowerShell to pass them all to a single git invocation.

**Action:** Accumulate target branch names into an array in PowerShell pipelines and execute native CLI commands once with the batched array argument.
