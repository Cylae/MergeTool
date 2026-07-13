
## 2024-05-18 - Avoiding N+1 Process Spawning in PowerShell Scripts
**Learning:** In PowerShell, repeatedly calling native executables like `git` inside loops (e.g., `git branch -D` inside a `ForEach-Object` loop) incurs significant process spawning overhead, drastically slowing down execution. The same applies to redundant executions of commands like `git checkout` when state hasn't actually mutated.
**Action:** When working with PowerShell and native executables, always look for opportunities to batch arguments (e.g., passing an array of branches to a single `git branch -D` command) and track state to avoid redundant command executions (e.g., skipping `git checkout` if already on the target branch).
