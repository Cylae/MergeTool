## 2026-08-17 - [Avoid N+1 Process Spawning in PowerShell Loops]
**Learning:** When executing native commands like `git` inside a PowerShell `ForEach-Object` loop, it creates a new process for each iteration (N+1 overhead). PowerShell automatically expands arrays passed to native commands into separate arguments, making batching easy and much faster.
**Action:** When performing bulk operations with native tools, collect items in an array first and pass the array to a single command execution whenever the tool supports batch inputs (like `git branch -D`).
