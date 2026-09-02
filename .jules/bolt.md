## 2026-09-02 - PowerShell Native Process Spawning Overhead
**Learning:** Calling native executables like `git` inside loops (e.g., `ForEach-Object`) in PowerShell causes significant N+1 process spawning overhead, drastically slowing down script execution on Windows/PowerShell environments.
**Action:** Always batch arguments for native executables into arrays and call the executable once outside the loop whenever possible.
