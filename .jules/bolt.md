## 2025-05-18 - Batch git branch deletion in PowerShell

**Learning:** Invoking external process binaries like `git` inside loops in PowerShell introduces significant process spawning overhead (N+1 invocations). PowerShell automatically expands array variables into separate arguments when passed to native executables.
**Action:** Collect arguments into an array using pipeline assignment `@(...)` and call the executable once with the array parameter (e.g. `git branch -D $branchesToDelete`) to execute a single batched operation.
