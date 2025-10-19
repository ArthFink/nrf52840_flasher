<!-- https://developers.home-assistant.io/docs/add-ons/presentation#keeping-a-changelog -->
## 0.2.3
- UI: device selector (Supervisor `device` type) and baudrate radio list for Silicon Labs Flasher–style config.
- Packaging: install legacy `nrfutil` (5.2.0) in a venv; add build deps for wheels.
- Translations: updated labels/descriptions for options.
- Docs: minor clarifications.

## 0.2.2
- Packaging: switch to Python virtualenv to avoid PEP 668 “externally managed” error.

## 0.2.0
- One-shot flashing flow (start → flash → stop), device/baud/URL options.

## 0.1.0
- Initial headless DFU flashing for PCA10059 using nrfutil.
