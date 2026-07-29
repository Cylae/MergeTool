## 2024-05-24 - Batching native commands in PowerShell

**Learning:** When executing native commands like `git` inside PowerShell scripts, calling them inside loops (like `ForEach-Object`) introduces significant N+1 process spawning overhead. PowerShell automatically expands arrays passed to native executables into separate arguments (e.g., passing `$branches` to `git branch -D $branches` runs `git branch -D branch1 branch2`). Also, if `git branch -D` encounters an error with one branch (like the currently checked out branch), it still proceeds to delete the others in the batch.

**Action:** Whenever iterating over items to run a native command, try to collect the items into an array and run the native command once with the array as an argument, suppressing `stderr` (`2>&1 | Out-Null`) if errors on individual items are expected and safe to ignore.
