## 2024-08-19 - Batch Process Calls
**Learning:** In PowerShell, when cleaning up Git branches, executing `git branch -D` inside a `ForEach-Object` pipeline spawns a new process for every single branch, resulting in massive O(N) overhead.
**Action:** Always collect items into an array using pipeline assignment (`@()`) and pass the entire array to the native executable as a batch, allowing it to process all items in a single O(1) process spawn.
