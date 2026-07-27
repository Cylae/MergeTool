## 2024-05-15 - Batched Git Branch Deletion in PowerShell
**Learning:** In PowerShell scripts containing `git` branch cleanup loops, using `ForEach-Object` with `git branch -D` spawns a new process for each branch. PowerShell natively maps array arrays variables to parameters gracefully, enabling batched arguments to commands like `git`.
**Action:** When working with shell or native processes in PowerShell loops, collect parameters in an array and use PowerShell's pipeline conversion to native arguments to execute a single, batched process to prevent N+1 process overhead.
