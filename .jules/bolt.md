## 2025-05-18 - Batch Local Branch Deletion in PowerShell

**Learning:** Invoking external process binaries like `git` inside PowerShell `ForEach-Object` loops introduces significant OS process spawning overhead (N+1 process creation cost). Since native commands accept arrays of arguments, batching argument collections and passing them to a single executable call drastically reduces execution time when handling multiple items.

**Action:** Whenever running native executables over a list of items in PowerShell, collect the items into an array first and pass the array in a single call (e.g. `git branch -D $branchesToDelete`) rather than executing inside a loop.
