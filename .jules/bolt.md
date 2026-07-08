## 2026-07-08 - [Batching Native Commands in PowerShell]
**Learning:** [Calling native executables like `git` inside a PowerShell `ForEach-Object` loop creates significant N+1 process spawning overhead, which can be easily avoided by collecting arguments into an array and passing them to the executable once.]
**Action:** [When processing collections in PowerShell scripts, always look for opportunities to batch arguments for native commands instead of spawning a new process for each item.]
