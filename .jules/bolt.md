## 2024-08-04 - [PowerShell Process Overhead]
**Learning:** Native command invocations (like `git`) inside `ForEach-Object` loops in PowerShell spawn processes iteratively, leading to N+1 overhead. PowerShell automatically unpacks arrays when passed to native commands, making batching trivial and much faster.
**Action:** When executing native binaries like Git over a collection of items, pipeline the collection directly to the native command or pass it as an array to allow the native binary to handle batch processing natively, eliminating redundant process creation overhead.
