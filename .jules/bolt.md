## 2024-05-24 - [Process Spawning Overhead Optimization]
**Learning:** Calling native executables (like `git`) inside PowerShell loops (e.g. `ForEach-Object`) creates significant N+1 process spawning overhead, which scales poorly (O(N)).
**Action:** Always batch arguments for native executables in PowerShell. Pass an array of arguments (e.g. `$branchesToDelete`) to a single native command execution to avoid spawning multiple processes.
