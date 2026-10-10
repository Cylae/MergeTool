## 2025-05-18 - Batch Local Branch Deletion

**Learning:** Invoking `git branch -D` inside a loop for every remaining local branch creates significant process spawning overhead (N+1 execution problem). PowerShell automatically expands array arguments when calling external native commands like `git`.

**Action:** Collect local branch names to delete into an array and pass them all in a single `git branch -D $branchesToDelete` call instead of using `ForEach-Object`.
