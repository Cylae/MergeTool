## 2023-10-25 - Native command process creation overhead
**Learning:** In PowerShell (especially on Windows where it's often run), invoking native executables inside a loop creates a new process for each iteration, which introduces massive overhead.
**Action:** When running native commands like Git against multiple items, collect the items into a single array and pass them batched to a single command execution if supported by the native CLI.
