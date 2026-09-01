## 2026-03-31 - Move git fetch out of PR conflict resolution loop
**Learning:** Network operations such as `git fetch` inside iterative conflict resolution loops add substantial latency overhead (typically 200ms - 1000ms per conflict). Since base branch refs do not need to be refetched for every PR resolution within a single script run, moving `git fetch` outside the loop reduces total network round-trips from N to 1.
**Action:** Always check if network fetch or pull operations inside loops can be hoisted before loop execution.
