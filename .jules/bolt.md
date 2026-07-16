## 2024-06-11 - [Batch Native Command Invocations in PowerShell]
**Learning:** PowerShell has significant overhead when spawning native processes (like `git`) inside a loop (N+1 problem). However, it natively expands array variables when passed as arguments to native commands.
**Action:** Always prefer collecting targets into a PowerShell array and executing the native command once (e.g. `git branch -D $branches`) rather than running it per item in a `ForEach-Object` loop.
