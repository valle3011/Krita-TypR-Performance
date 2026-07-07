# TypeR Performance (test build)

A low-power test build of the **TypeR** Krita plugin for weak / old laptops.
It **installs next to** the normal TypeR — different plugin id, package name and
settings namespace — so both can be enabled at once without clashing.

> This build ships the typesetting workflow only. The experimental automatic
> bubble detection (BubblR) is **not** part of this release.

## Install into Krita

Easiest: run **`INSTALL.bat`** (double-click). It copies the plugin into Krita's
resource folder for you. `UNINSTALL.bat` removes it again.

Manual install — copy **both** of these into Krita's `pykrita` folder:

- `typer_perf.desktop`
- the `typer_perf/` folder

Path on Windows: `C:\Users\<name>\AppData\Roaming\krita\pykrita\`

Then in Krita: **Settings → Configure Krita → Python Plugin Manager** →
enable **"TypeR Performance (test)"** → restart Krita. The docker appears under
**Settings → Dockers → TypeR … Performance**.

The original TypeR stays installed and untouched.

## What's different from normal TypeR

Same layout results — the inserted text layers look identical. This build just
does the same work far less often:

1. **Debounced live preview** — typing / dragging a slider no longer triggers a
   full size-fitting re-layout on every event; the repaint fires once after a
   short pause (~120 ms).
2. **Cached size-fit** — the preview's binary-search fit is reused on repaints
   where nothing layout-relevant changed (resize, focus, colour/alignment
   tweaks), instead of recomputing every paint.
3. **Lite mode (weak PC)** — a checkbox in the live-preview panel, **on by
   default** in this build:
   - live preview stops auto-updating → a **Refresh preview** button redraws it
     on demand (no cost while typing),
   - anti-aliasing is skipped (cheaper on weak GPUs).
4. **Hyphenation memo** — syllable breaks are computed once per word, not at
   every candidate font size during the fit search.

Lite mode is remembered per machine (Krita setting `typer_perf/liteMode`).

## How to use

Load a script (`.docx` / `.odt` / `.txt`), step through it line by line, pick a
font and settings, and **Insert** to place each line as a text layer. In Lite
mode the preview updates when you click **Refresh preview** (or on Insert).

## Tests

`python test_typer_logic.py` — 98 passed (the Qt-free layout / hyphenation /
panel-layout logic, run without Krita).

## License

The bundled hyphenation patterns keep their own license (see
`typer_perf/hyph/LICENSE.txt`).
