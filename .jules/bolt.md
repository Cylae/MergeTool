## 2026-07-02 - Batch git branch deletion in PowerShell

**Learning:** Spawning a new native executable (`git branch -D`) in a loop (`ForEach-Object`) for every local branch introduces significant process creation overhead in PowerShell scripts. PowerShell automatically flattens arrays when passed to native applications, allowing `git branch -D` to accept multiple branch names in a single invocation.

**Action:** Whenever operating on multiple git entities (branches, files, commits) in PowerShell, collect entity names into an array and pass the array directly to `git` once instead of invoking `git` repeatedly inside a loop.
