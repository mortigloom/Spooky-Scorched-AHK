# Spooky Scorched AHK

[Download the standalone Windows EXE](https://github.com/mortigloom/Spooky-Scorched-AHK/releases/latest)

No AutoHotkey installation required. Download **SpookyScorchedChat.exe** from the release Assets.

## Use

1. Launch the EXE. It starts paused.
2. Focus the target application and press **F1** to start.
3. Press **F1** again to pause. Press it again to resume at the saved position.
4. Right-click the tray icon and choose **Exit** to close.

Loop: **E down → hold 50 ms → E up → wait 600 ms → Space down → hold 50 ms → Space up → wait 600 ms → repeat.**

Pausing preserves the next key and remaining wait. A press already underway completes its 50 ms hold and releases before pausing, so no key remains held. Holding F1 toggles only once. Keys go to the foreground application. Restarting resets the sequence to E. Timing is approximate due to Windows scheduling.

## Build

Install Python and LIEF 1.0.0 (`python -m pip install lief==1.0.0`). Download the official AutoHotkey v2 ZIP from https://www.autohotkey.com/download/ahk-v2.zip and extract AutoHotkey64.exe next to build.py. Run `python build.py`.

The build embeds the script as Win32 RCDATA resource ID 1 in the official interpreter, producing a self-contained Windows x64 EXE. The GitHub Actions workflow verifies the downloaded runtime archive against its recorded SHA-256, validates the embedded script, and publishes an EXE and source ZIP. A future runtime download change requires updating that checksum after verification.

## Validation

The original EXE's x64 PE structure and embedded script were checked after building. Windows execution and in-game behavior have **not** been tested in the build environment. Verify E/Space and F1 pause/resume in a text editor before use.

## License

GNU GPL v2 or later; see license.txt. Includes the official AutoHotkey 2.0.31 runtime, copyright its respective authors. Corresponding runtime source: https://github.com/AutoHotkey/AutoHotkey/tree/v2.0.31 . Macro source and build instructions are included.
