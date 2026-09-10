## 2025-02-14 - Batch local git branch deletion
**Learning:** Calling `git branch -D` inside a `ForEach-Object` loop introduces N+1 process creation overhead. Passing an array of branch names directly to a single `git branch -D` invocation batches argument handling into a single `git` process execution in PowerShell.
**Action:** Always batch array arguments for native binaries like `git` instead of invoking them inside loops.
