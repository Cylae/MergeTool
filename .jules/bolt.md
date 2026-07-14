## 2024-05-24 - Avoid N+1 process spawning in PowerShell
**Learning:** Calling external native binaries (like `git`) inside a loop (like `ForEach-Object`) in PowerShell causes significant process spawning overhead (N+1 problem). This is a common performance bottleneck in PowerShell scripts acting as wrappers for CLI tools.
**Action:** Always batch arguments into an array and call the external binary once with the batched arguments instead of calling it repeatedly in a loop.
