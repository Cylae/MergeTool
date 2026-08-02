## 2026-08-02 - Batched Native Command Execution in PowerShell
**Learning:** Calling native executables (like `git`) inside a PowerShell `ForEach-Object` loop introduces significant N+1 process spawning overhead. PowerShell natively unpacks arrays passed to native commands as separate arguments, enabling easy and safe batching without complex string joining.
**Action:** Always batch arguments for native commands instead of looping when possible.
