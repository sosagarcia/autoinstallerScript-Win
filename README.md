# 🛠️ AutoInstaller with PowerShell & Winget

This script automates the installation (and update) of multiple programs using `winget`, based on a list defined in a CSV file.

## 📄 CSV Format

The input file must be named `programs.csv` and placed in the same directory as the script. It must contain the following headers:

```
name,version,quiet
Spotify,latest,yes
putty,,yes
Python.Python.3,3.11.9,yes
```

- name: The winget ID of the application (use winget search to find IDs).

- version: Optional. Use latest or leave empty for the latest version.

- quiet: Optional. Use yes to run in silent mode (no user interaction).

## ⚙️ How It Works

- Automatically requests admin privileges if not already elevated.

- Installs or updates each program in the list.

- Uses --silent if requested.

- Falls back to winget upgrade if install fails.

## ▶️ How to Run

1. Open PowerShell as administrator.

2. Unblock script execution temporarily:

`Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process`

3. Run the script:

`.\Autoinstaller.ps1`