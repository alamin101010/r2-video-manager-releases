# One-command installer for teammates (no git, no Node, no token needed).
# Usage: irm https://raw.githubusercontent.com/alamin101010/r2-video-manager-releases/main/bootstrap.ps1 | iex
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

$Owner = 'alamin101010'
$Repo = 'r2-video-manager-releases'  # TODO: confirm repo name
$ExeName = 'R2 Video Manager.exe'
$StateDir = Join-Path $env:USERPROFILE '.r2-video-manager'
$Headers = @{ 'X-GitHub-Api-Version' = '2022-11-28' }

Write-Host 'Checking latest release...'
$Release = Invoke-RestMethod -Headers ($Headers + @{ Accept = 'application/vnd.github+json' }) "https://api.github.com/repos/$Owner/$Repo/releases/latest"
$Asset = $Release.assets | Where-Object { $_.name -like '*.exe' } | Select-Object -First 1
if (-not $Asset) { throw 'No Windows installer found in the latest release.' }

$Installer = Join-Path $env:TEMP $Asset.name
Write-Host "Downloading $($Asset.name) ($($Release.tag_name))..."
Invoke-WebRequest -Headers ($Headers + @{ Accept = 'application/octet-stream' }) "https://api.github.com/repos/$Owner/$Repo/releases/assets/$($Asset.id)" -OutFile $Installer

if (Get-Process -Name 'R2 Video Manager' -ErrorAction SilentlyContinue) {
  Write-Host 'Quitting running app...'
  Stop-Process -Name 'R2 Video Manager' -Force
  Start-Sleep -Seconds 2
}

Write-Host 'Installing...'
Start-Process -FilePath $Installer -ArgumentList '/S' -Wait
Remove-Item $Installer -ErrorAction SilentlyContinue

New-Item -ItemType Directory -Force -Path $StateDir | Out-Null
Set-Content -Path "$StateDir\version" -Value ($Release.tag_name -replace '^v', '')

$Exe = Join-Path $env:LOCALAPPDATA "Programs\r2-video-manager\$ExeName"
if (Test-Path $Exe) { Start-Process $Exe }
Write-Host "Done. Installed $($Release.tag_name)."
