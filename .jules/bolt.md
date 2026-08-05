## 2026-08-05 - Batching Native Executable Arguments in PowerShell
**Learning:** Calling native executables (like `git`) inside a PowerShell `ForEach-Object` loop introduces significant N+1 process creation overhead, which is extremely slow on OSs like Windows. Passing a string array directly to the executable leverages automatic expansion and drastically speeds up execution.
**Action:** Always batch arguments and pass arrays directly to native executables in PowerShell scripts rather than looping over them.
