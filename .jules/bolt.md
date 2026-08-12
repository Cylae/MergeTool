## 2024-05-20 - Batch native commands in PowerShell loops
**Learning:** Calling native executables (like `git`) inside PowerShell loops creates massive N+1 overhead because PS spins up a new OS process every single time.
**Action:** When filtering and acting on a list of items using native tools, always batch the items into an array first and pass the entire array to a single call of the native tool (PowerShell auto-expands the array into arguments).
