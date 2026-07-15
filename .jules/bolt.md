## 2024-05-24 - [Avoid N+1 Process Spawning in PowerShell]
**Learning:** Native executable invocations in PowerShell loops (like `git branch -D` inside a `ForEach-Object`) create significant overhead due to process spawning (N+1 anti-pattern).
**Action:** Always batch arguments and pass them to the native executable as an array to minimize process invocations.
