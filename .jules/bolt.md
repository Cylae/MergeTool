## 2024-03-24 - Avoiding N+1 native process spawning overhead in PowerShell scripts
**Learning:** Calling native executables (like `git`) inside a loop (e.g., `ForEach-Object`) in PowerShell incurs a significant overhead for each invocation due to process creation costs.
**Action:** Always batch arguments and execute the native tool once whenever possible (e.g., passing an array of branch names to `git branch -D` instead of looping over each branch).

## 2024-03-24 - Avoiding redundant state restorations and array reallocation overhead
**Learning:** Performing a state restoration command (like `git checkout main --force`) inside a loop on every iteration, even when the state hasn't changed, introduces significant delay (e.g., waiting for the `git` native process). Similarly, using `+=` on an array in PowerShell is O(N^2) because it allocates a new array in memory each time.
**Action:** Use flags to track state changes and only restore state if it actually mutated. Use pipeline assignment `$var = command | Where-Object ...` instead of initializing an empty array and doing `$var += ...` in a loop.
