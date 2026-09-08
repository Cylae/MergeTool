## 2026-09-08 - [Avoid N+1 Process Spawning in Native CLI Loops]
**Learning:** Calling native CLI tools (like `git`) inside a PowerShell loop (e.g., `ForEach-Object`) introduces significant process spawning overhead (O(N)), making scripts extremely slow for large datasets. PowerShell natively expands arrays into arguments when passed to native executables.
**Action:** When automating native CLI actions, collect targets in an array first and pass the entire array to the native command in a single call, allowing the native CLI tool to handle the batch processing internally.
