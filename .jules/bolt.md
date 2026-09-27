## 2025-05-18 - Batch Git Branch Deletion in PowerShell

**Learning:** Invoking native CLI executables (such as `git`) inside PowerShell loops like `ForEach-Object` introduces severe process creation overhead (N+1 execution problem). PowerShell automatically expands arrays passed as arguments to native commands into individual command line arguments (`git branch -D branch1 branch2 ...`).

**Action:** Collect arguments into an array using pipeline assignment `@(...)` and pass the array to a single native command invocation to batch processing and dramatically improve performance.
