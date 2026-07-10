## 2024-07-10 - [Batching Native Commands]
**Learning:** [In PowerShell scripts, calling a native executable (like `git`) inside a loop (`ForEach-Object`) causes a significant N+1 process spawning overhead.]
**Action:** [To avoid this, collect the arguments into an array and pass them to the native executable in a single call (e.g., `git branch -D $branchesToDelete`).]