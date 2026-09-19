## 2025-05-18 - Batch Local Branch Deletion in Git Cleanup

**Learning:** Calling `git branch -D` inside a `ForEach-Object` loop introduces significant process spawning overhead (N subshell invocations). Batching all branch names into a single array and passing them to `git branch -D` reduces total execution time from ~1.3s - 1.7s down to ~80ms - 98ms for 50 branches (~16x - 18x speedup).

**Action:** Whenever performing bulk operations with native binaries like `git` in PowerShell scripts, filter and collect target items into an array first, then invoke the command once with the full list of arguments.
