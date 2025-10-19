# nRF52840 DFU Flasher (Headless, One-shot)

Flashes the **Nordic nRF52840 USB Dongle (PCA10059)** via **USB DFU** using `nrfutil` and a DFU `.zip`. The add-on **runs once** and then **stops**, similar to Silicon Labs Flasher.

## Prerequisites
- A release artifact that is a **DFU .zip** (e.g., `ot-rcp-USB.zip`).
- Dongle in **DFU bootloader** (press reset) → appears as `/dev/ttyACM*`.

## Options
- **device**: serial device (recommend `/dev/serial/by-id/...`).
- **baudrate**: 57600, 115200, 230400, 460800, 921600 (default 115200).
- **flow_control**: enable hardware flow control if required.
- **firmware_source**: `github:owner/repo@latest` or `@vX.Y.Z`, or `url:https://…/file.zip`, or `file:/share/file.zip`.
- **dry_run**, **verbose**: diagnostics.

## Usage
1. Put the dongle in DFU mode (press reset).
2. Open **Configuration**: set *Device*, *Baudrate*, *Firmware source*.
3. Click **Start**. It flashes once and the add-on **stops**.
4. Logs: Supervisor log and `/share/nrf52840_dfu_flasher/flasher.log`.
