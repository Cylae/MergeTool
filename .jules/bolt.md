## 2025-05-18 - Batch git branch deletion in PowerShell

**Learning:** Invoking external binaries like `git` inside PowerShell loops (such as `ForEach-Object`) introduces severe process creation overhead (N+1 problem). Batching arguments into a single native call significantly improves performance.

**Action:** Use `git branch --format="%(refname:short)"` to retrieve local branch names and pass the collected array directly to `git branch -D $branches` instead of iterating and executing `git` per branch.
