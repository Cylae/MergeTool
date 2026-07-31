## 2026-07-31 - Batching Native Executable Arguments in PowerShell
**Learning:** Calling native executables like `git` inside a PowerShell `ForEach-Object` loop introduces significant O(N) process spawning overhead. However, PowerShell automatically expands arrays when passed as arguments to native commands.
**Action:** Always collect arguments into an array first, then pass the array to the native executable to achieve O(1) process creation.
