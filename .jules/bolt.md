## 2026-07-23 - [Batching Native Command Calls in PowerShell]
**Learning:** Native executable calls within a loop (`ForEach-Object`) in PowerShell spawn individual processes and introduce significant overhead (N+1 process spawning). Passing an array to a native command correctly expands the array to arguments natively.
**Action:** When invoking tools like `git` within PowerShell scripts, favor pipelining input into an array and passing the array as an argument directly rather than repeatedly launching the process inside a `ForEach-Object` block.
