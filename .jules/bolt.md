## 2026-09-16 - Batch local git branch deletion in PowerShell

**Learning:** Invoking `git branch -D` inside a `ForEach-Object` loop in PowerShell creates N+1 process spawning overhead when deleting multiple local branches. PowerShell automatically expands arrays passed to native commands as distinct command arguments.
**Action:** Collect local branches into an array and pass them all at once to `git branch -D $branchesToDelete` instead of deleting them sequentially in a loop.
