## 2026-10-11 - Batching Git Branch Deletion in PowerShell

**Learning:** Invoking external CLI tools (like `git`) inside PowerShell loops (`ForEach-Object`) introduces severe N+1 process creation overhead. Passing an array of arguments to native commands in a single batch call allows PowerShell to pass all arguments to a single executable process, resulting in over 12x performance improvement (~1380ms vs ~108ms for 50 branches).

**Action:** Whenever performing bulk operations with native CLI tools in PowerShell, collect target arguments into an array and execute the native command once with the entire array rather than looping over individual items.
