## 2025-05-18 - Batch Local Branch Deletion in PowerShell Cleanup

**Learning:** Calling native executables inside `ForEach-Object` loops in PowerShell introduces significant process spawning overhead (N+1 process creation). PowerShell automatically expands arrays passed to native commands into individual command-line arguments.

**Action:** Whenever invoking native binaries (such as `git`) in PowerShell loops, collect argument targets into an array `@(...)` and invoke the binary once with the batched array argument.
