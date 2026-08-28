## 2024-05-15 - [Batched git operations in PowerShell]
**Learning:** Calling native binaries like `git` inside loops (e.g., `ForEach-Object`) causes significant N+1 process spawning overhead. PowerShell automatically expands arrays passed to native commands, allowing for efficient batching (e.g., `$branches = @(...); git branch -D $branches`).
**Action:** Always look for opportunities to aggregate arguments into arrays and call external processes once rather than looping over them.
