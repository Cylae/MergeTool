## 2026-09-01 - Conditional Git Checkout in Automation Loop
**Learning:** In PR processing loops, running `git checkout $BaseBranch --force` unconditionally on every iteration causes unnecessary process spawning and disk I/O when most PRs merge directly via API without local branch switches.
**Action:** Track when a local branch checkout actually occurred using a flag (`$needsCheckout = $true`) and conditionally run `git checkout $BaseBranch --force` only when needed.
