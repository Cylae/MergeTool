## 2023-08-26 - [N+1 Native Command Overhead in PowerShell]
**Learning:** Native command invocations (like calling `git`) from within PowerShell loops (like `ForEach-Object`) incur significant process spawning overhead on Windows. PowerShell automatically unpacks arrays into separate arguments when passed to native commands.
**Action:** When working with PowerShell and native commands, batch arguments into arrays and call the native command once to avoid O(N) process creation time overhead.
