## 2026-07-30 - Batch Execution of Native Commands in PowerShell
**Learning:** Calling native executables (like `git`) inside a PowerShell `ForEach-Object` loop introduces significant N+1 process spawning overhead, which can be a severe performance bottleneck.
**Action:** Always batch arguments into an array and pass them to a single invocation of the native command when possible, allowing PowerShell to expand the array into separate arguments automatically.
