## 2024-05-18 - [Batching Git Commands in PowerShell]
**Learning:** [In PowerShell scripts, calling external executables like `git` inside loops creates significant process-spawning overhead. Batching arguments and executing the command once dramatically improves performance.]
**Action:** [Always look for opportunities to batch native command execution in PowerShell rather than iterating through lists and calling the command individually.]
