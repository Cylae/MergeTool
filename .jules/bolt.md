## 2024-05-24 - [Avoid N+1 process overhead when calling native executables from PowerShell]
**Learning:** Calling native executables like `git` inside loops (e.g. `ForEach-Object`) creates substantial process spawning overhead, especially if the collection is large. PowerShell automatically expands arrays passed to native commands.
**Action:** Instead of iterating, filter the items into an array using pipeline operations (`Where-Object`, `ForEach-Object`) and pass the entire array directly as an argument to the native executable, batching the operation and avoiding the N+1 overhead.
