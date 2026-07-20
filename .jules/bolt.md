## 2024-07-20 - Batching Native Command Arguments in PowerShell
**Learning:** Calling native executables like `git` inside a PowerShell `ForEach-Object` loop incurs significant N+1 process spawning overhead. PowerShell automatically expands arrays when passed to native commands.
**Action:** Always batch arguments into an array and pass them to a single native command execution to avoid spawning redundant processes.
