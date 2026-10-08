## 2025-05-18 - Batch process spawning in PowerShell local branch cleanup
**Learning:** Calling `git branch -D` inside a `ForEach-Object` pipeline loop incurs massive O(N) process creation and teardown overhead when deleting multiple local branches. Passing an array of branch names directly to a single `git branch -D` call allows git to delete all targeted branches in a single process invocation.
**Action:** Always batch array arguments for native CLI tools like `git` in PowerShell scripts instead of executing CLI binaries inside loops.
