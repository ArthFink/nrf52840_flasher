#!/usr/bin/env bash
set -euo pipefail
ZIP="$1"          # DFU package .zip
PORT="$2"         # /dev/ttyACM*
DRY="${3:-false}"
VERBOSE="${4:-true}"
BAUD="${5:-115200}"
FLOWCTL="${6:-false}"

[ -f "$ZIP" ]  || { echo "[nrfutil] DFU zip not found: $ZIP"; exit 1; }
[ -e "$PORT" ] || { echo "[nrfutil] Serial port not found: $PORT"; exit 1; }

if [ "$VERBOSE" = "true" ]; then set -x; fi

ARGS=(dfu usb-serial -pkg "$ZIP" -p "$PORT" -b "$BAUD")
if [ "$FLOWCTL" = "true" ]; then
  ARGS+=(--flowcontrol)
fi

CMD=(nrfutil "${ARGS[@]}")
echo "[nrfutil] ${CMD[*]}"
if [ "$DRY" = "true" ]; then
  echo "[nrfutil] dry-run: not flashing"
  exit 0
fi
"${CMD[@]}"
echo "[nrfutil] DFU complete"
