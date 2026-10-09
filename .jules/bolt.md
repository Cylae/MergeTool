## 2026-10-09 - Batch local branch deletion in script.ps1

**Learning:** Iteratively executing native external commands like `git branch -D` inside PowerShell loops (such as `ForEach-Object`) incurs high process creation and teardown overhead (N+1 process spawning). Passing an array of arguments to native commands in PowerShell allows single-invocation execution.

**Action:** Whenever operating on multiple Git refs or branches, collect target branch names into an array and pass them all at once to a single `git branch -D $branches` invocation.
