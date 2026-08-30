## 2026-08-30 - [Optimize git branch deletion]
**Learning:** Calling native executables inside a loop in PowerShell introduces O(N) process spawning overhead.
**Action:** Always collect target data via the pipeline and pass it to native executables as arrays whenever they support batch processing to reduce overhead to O(1).
