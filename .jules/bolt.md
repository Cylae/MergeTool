## 2026-07-04 - [Batching Native Commands in PowerShell]
**Learning:** [When cleaning up resources using native CLI tools (like git) in PowerShell scripts, looping and spawning a new process for each item causes noticeable O(N) overhead. PowerShell gracefully unrolls arrays into separate arguments for native executables.]
**Action:** [Always look for opportunities to batch arguments and execute a single process spawn instead of looping when using CLI tools inside scripts.]
