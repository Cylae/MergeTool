## 2024-08-01 - [Avoid N+1 Process Spawns in PowerShell]
**Learning:** Native command executions in PowerShell (like `git.exe`) are significantly slower than native PowerShell commands due to process creation overhead. Running native commands in a loop (like `ForEach-Object`) creates an N+1 performance bottleneck.
**Action:** Always batch arguments for native commands instead of using loops whenever the underlying executable supports it (e.g., passing an array of branches to `git branch -D`).
