# R2 Video Manager — downloads

Installers for the 10ms R2 Video Manager (macOS and Windows). This repo holds builds only; each person enters their own R2 keys in the app.

## Install

Go to **[Releases](../../releases/latest)** and download:
- **Mac (Apple Silicon):** `R2 Video Manager-<version>-arm64.dmg`
- **Mac (Intel):** `R2 Video Manager-<version>.dmg`
- **Windows:** `R2-Video-Manager-Setup-<version>.exe`

Not sure which Mac? Apple menu → About This Mac. "Apple M1/M2/M3…" = Apple Silicon, "Intel" = Intel.

The app is unsigned, so the first launch shows a one-time warning:
- **Mac:** right-click the app → **Open** → **Open**.
- **Windows:** **More info → Run anyway**.

## Updating

When a new version is out, a banner appears in the app. Click **Update now**, then **Restart to update**. Nothing installs without your click.

## Terminal install (optional)

macOS: `curl -fsSL https://raw.githubusercontent.com/alamin101010/r2-video-manager-releases/main/bootstrap.sh | bash`

Windows (PowerShell): `irm https://raw.githubusercontent.com/alamin101010/r2-video-manager-releases/main/bootstrap.ps1 | iex`
