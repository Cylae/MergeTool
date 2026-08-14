## 2024-05-24 - Batching native commands to avoid N+1 process spawning
**Learning:** In PowerShell, invoking a native executable (like `git`) inside a loop (e.g., `ForEach-Object`) creates a new process for each iteration, causing significant N+1 process spawning overhead.
**Action:** Always batch arguments into an array and pass them directly to a single invocation of the native executable. PowerShell automatically expands arrays passed to native commands, making it easy to safely batch operations.
