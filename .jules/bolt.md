## 2026-07-17 - [Batched Native Commands in PowerShell]
 **Learning:** [PowerShell automatically expands arrays into separate command line arguments for native executables like Git. Git commands like `branch -D` can accept multiple arguments to delete many branches at once, bypassing the need for a ForEach-Object loop around the native process.]
 **Action:** [When cleaning up or manipulating Git resources in PowerShell scripts, always check if the native Git command supports batched arguments before executing it inside a loop to prevent N+1 process creation overhead.]
