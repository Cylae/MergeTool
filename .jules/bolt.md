# Bolt Performance Journal

## 2025-05-20 - Batching Native Executable Arguments in PowerShell

**Learning:** Invoking external process executables (like `git branch -D`) inside PowerShell pipeline loops (`ForEach-Object`) incurs severe process creation overhead for each iteration. In PowerShell, passing an array of arguments to a native command automatically expands the array into individual command line parameters (e.g. `git branch -D branch1 branch2 ...`).

**Action:** Whenever performing bulk operations with native binaries in PowerShell, collect target items into an array using pipeline assignment `@(...)` and invoke the binary once with the array argument instead of iterating with `ForEach-Object`.
