# Bolt Performance Journal

## 2026-10-07 - Batch Local Branch Deletion in Merge Script
**Learning:** Calling `git branch -D` inside a loop (`ForEach-Object`) for every remaining local branch incurs significant process creation overhead (N+1 git executable spawns). Batching all non-base branch names into an array and passing them to a single `git branch -D` call reduces execution time dramatically.
**Action:** Always collect branch names into an array and issue a single batched `git branch -D $branchesToDelete` command instead of invoking git per branch in a loop.
