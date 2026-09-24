## 2026-03-06 - Batching Git Branch Deletion in Cleanup

**Learning:** Calling `git branch -D` inside a PowerShell `ForEach-Object` pipeline introduces significant N+1 process creation overhead when cleaning up local branches. Passing an array of branch names directly to a single `git branch -D` call reduces git process spawning from N invocations to 1 invocation.

**Action:** Whenever operating on multiple git targets (branches, tags, commits) in PowerShell scripts, collect the targets into a PowerShell array and invoke `git` once with the array as arguments rather than looping over targets individually.
