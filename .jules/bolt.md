## 2026-09-22 - Batch Local Branch Cleanup in PowerShell

**Learning:** Invoking `git branch -D` sequentially inside a loop (`ForEach-Object`) introduces significant process spawning overhead (N+1 invocations). Batching all branch targets into a single `git branch -D $branches` call dramatically reduces execution time.

**Action:** Whenever operating on multiple git refs in PowerShell, collect the target list into an array and pass them in a single native command call rather than running executable commands inside `ForEach-Object`.
