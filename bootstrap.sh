#!/bin/bash
# One-command installer for teammates (no git, no Node, no token needed).
# Usage: curl -fsSL https://raw.githubusercontent.com/alamin101010/r2-video-manager-releases/main/bootstrap.sh | bash
set -euo pipefail

OWNER=alamin101010
REPO=r2-video-manager-releases  # TODO: confirm repo name
APP="R2 Video Manager"
STATE_DIR="$HOME/.r2-video-manager"

api() { curl -fsSL -H "X-GitHub-Api-Version: 2022-11-28" "$@"; }

echo "Checking latest release..."
RELEASE="$(api -H "Accept: application/vnd.github+json" "https://api.github.com/repos/$OWNER/$REPO/releases/latest")"

ARCH="$(uname -m)"; [ "$ARCH" = "x86_64" ] && ARCH=x64
PICK="$(RELEASE="$RELEASE" ARCH="$ARCH" osascript -l JavaScript -e '
  ObjC.import("stdlib");
  var r = JSON.parse($.getenv("RELEASE")), arch = $.getenv("ARCH");
  var zips = r.assets.filter(function (a) { return /\.zip$/.test(a.name); });
  var a = zips.filter(function (x) { return x.name.indexOf(arch) >= 0; })[0]
       || zips.filter(function (x) { return x.name.indexOf("arm64") < 0; })[0];
  a ? r.tag_name + "|" + a.id + "|" + a.name : "";
')"
[ -n "$PICK" ] || { echo "No macOS build found in the latest release." >&2; exit 1; }
IFS='|' read -r TAG ASSET_ID ASSET_NAME <<< "$PICK"

echo "Downloading $ASSET_NAME ($TAG)..."
TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
api -H "Accept: application/octet-stream" "https://api.github.com/repos/$OWNER/$REPO/releases/assets/$ASSET_ID" -o "$TMP/app.zip"

if pgrep -x "$APP" >/dev/null; then
  echo "Quitting running app..."
  osascript -e "tell application \"$APP\" to quit" >/dev/null 2>&1 || true
  for _ in $(seq 20); do pgrep -x "$APP" >/dev/null || break; sleep 0.5; done
  pkill -x "$APP" 2>/dev/null || true
fi

echo "Installing to /Applications..."
rm -rf "/Applications/$APP.app"
ditto -xk "$TMP/app.zip" /Applications
xattr -dr com.apple.quarantine "/Applications/$APP.app" 2>/dev/null || true

mkdir -p "$STATE_DIR"
printf '%s\n' "${TAG#v}" > "$STATE_DIR/version"

open "/Applications/$APP.app"
echo "Done. Installed ${TAG} — find it in Applications."
