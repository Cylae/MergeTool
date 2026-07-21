## 2024-05-24 - PowerShell Pipeline vs Array Appending

**Learning:** When collecting results in a loop in PowerShell, appending to an array using `+=` has an O(N^2) overhead because it reallocates the array every time.
**Action:** Use pipeline assignment (e.g., `$var = command | ForEach-Object ...`) to collect items efficiently, especially when preparing large arrays for batch processing.
