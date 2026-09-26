# R2 Video Manager — downloads

Installers for the 10ms R2 Video Manager (macOS and Windows). This repo holds builds only; each person enters their own R2 keys in the app.

## Install

| I use | Download (always the newest version) |
|---|---|
| **Windows** | [R2-Video-Manager-Windows-Setup.exe](https://github.com/alamin101010/r2-video-manager-releases/releases/latest/download/R2-Video-Manager-Windows-Setup.exe) |
| **Mac, Apple Silicon** (M1, M2, M3, M4) | [R2-Video-Manager-Mac-Apple-Silicon.dmg](https://github.com/alamin101010/r2-video-manager-releases/releases/latest/download/R2-Video-Manager-Mac-Apple-Silicon.dmg) |
| **Mac, Intel** | [R2-Video-Manager-Mac-Intel.dmg](https://github.com/alamin101010/r2-video-manager-releases/releases/latest/download/R2-Video-Manager-Mac-Intel.dmg) |

Not sure which Mac? Apple menu → **About This Mac**.

The app is unsigned, so the first launch shows a one-time warning:
- **Windows:** **More info → Run anyway**.
- **Mac:** System Settings → Privacy & Security → **Open Anyway** (older macOS: right-click the app → **Open**).

## Updating

When a new version is out, a banner appears in the app. Click **Update now**, then **Restart to update**. Nothing installs without your click.

## Terminal install (optional)

macOS: `curl -fsSL https://raw.githubusercontent.com/alamin101010/r2-video-manager-releases/main/bootstrap.sh | bash`

Windows (PowerShell): `irm https://raw.githubusercontent.com/alamin101010/r2-video-manager-releases/main/bootstrap.ps1 | iex`
