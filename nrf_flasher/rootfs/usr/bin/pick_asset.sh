#!/usr/bin/env bash
set -euo pipefail
SRC="$1"
OUT="/tmp/fw_selected"
rm -f "$OUT".* 2>/dev/null || true

# Accept: github:owner/repo@tag|latest  OR  url:https://...zip  OR  file:/share/path.zip
if [[ "$SRC" == url:* ]]; then
  URL="${SRC#url:}"
  curl -fsSL "$URL" -o "$OUT.zip"
  echo "$OUT.zip"; exit 0
elif [[ "$SRC" == file:* ]]; then
  PATH_ON_HOST="${SRC#file:}"
  cp "$PATH_ON_HOST" "$OUT.zip"
  echo "$OUT.zip"; exit 0
elif [[ "$SRC" == github:* ]]; then
  SPEC="${SRC#github:}"          # owner/repo@tag|latest
  OWNER_REPO="${SPEC%@*}"
  TAG="${SPEC#*@}"
  if [[ "$TAG" == "latest" || "$TAG" == "$SPEC" ]]; then
    API="https://api.github.com/repos/${OWNER_REPO}/releases/latest"
  else
    API="https://api.github.com/repos/${OWNER_REPO}/releases/tags/${TAG}"
  fi
  ASSETS=$(curl -fsSL "$API")
  URL=$(echo "$ASSETS" | jq -r '.assets[].browser_download_url | select(endswith(".zip"))' | head -n1)
  if [[ -z "${URL:-}" ]]; then
    echo "No .zip DFU asset found in $SRC" >&2; exit 1
  fi
  curl -fsSL "$URL" -o "$OUT.zip"
  echo "$OUT.zip"; exit 0
else
  echo "Unsupported source: $SRC" >&2; exit 2
fi
