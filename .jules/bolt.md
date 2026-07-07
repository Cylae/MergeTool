## 2024-05-24 - PowerShell N+1 Process Spawning
**Learning:** Calling native executables inside PowerShell loops (`ForEach-Object`) creates significant overhead due to process spawning (N+1 problem). This is a codebase-specific pattern that affects performance during operations like cleaning up many git branches.
**Action:** Always look for opportunities to batch arguments and pass them as an array to a single invocation of a native executable.
