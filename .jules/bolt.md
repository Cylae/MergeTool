## 2025-05-18 - Batch Local Branch Deletion in PowerShell

**Learning:** Invoking external commands (like `git branch -D`) inside a PowerShell `ForEach-Object` loop creates substantial process spawning overhead (N+1 execution pattern). Batching arguments into a single native process invocation drastically reduces execution time.

**Action:** Accumulate array parameters into a single variable using pipeline array assignment `@(...)` and pass them to native binaries in a single call whenever supported.
