# Custom Hotkeys test preview

**TL;DR:** 0.1.1 groups shortcuts by purpose, aligns text, adds a live search
field and18 rows, and removes redundant hints/buttons. Grid keeps native groups: Ctrl+number assigns, number selects,
and pressing it again focuses. Enable the module, open with F12, edit and Apply.

This is an **unsigned, incomplete test build**, not the signed Store release.
The Store recipe is a draft proposal; do not publish it before the implementation
and required acceptance gates in the linked extension PR are complete.

Download [custom-hotkeys-0.1.1.zip](custom-hotkeys-0.1.1.zip?raw=true).
Source: `ce9385f5c5ff1d10134d66c36d857f8e51339355` in
[extension-custom-hotkeys](https://github.com/Krarilotus/extension-custom-hotkeys/tree/ce9385f5c5ff1d10134d66c36d857f8e51339355).
Size:87,775 bytes. SHA-256:
`2122b341bdc88ed7d857c8c4cefa3843c9c9421e3a7f47b1e52cc9de6118eb58`.
The adjacent build receipt contains the per-file hashes. Two independent builds
were byte-identical. Images/descriptions and test tools are excluded from the ZIP.

Use a separate SHC1.41/UCP3.0.7 test installation. Place the ZIP in `ucp/modules`
and activate Custom Hotkeys with its declared dependencies: UI1.0.1,
LuaJIT1.0.0, cffi1.0.0, winProcHandler1.0.0, graphicsApiReplacer1.3.0.
It starts with the module; there is no separate launcher switch or options page.
Open the main-menu entry or press **F12** in a supported menu/live SP game.
**Ctrl+Shift+F12** is the recovery entry. Change bindings and use **Apply** to save.
The unsigned-development startup notice is expected for this test ZIP.

Legacy is not required. If active, its hotkey modifications must be off
(`o_keys.enabled=false`); this is a required configuration value and runtime gate.
Do not combine this preview with active Recorder. Other executable hashes,
including Extreme, are rejected by the current implementation.

![Actual in-game hotkey editor](https://raw.githubusercontent.com/Krarilotus/extension-custom-hotkeys/f67fc6d9779f8ffe12b6ebd72462f317a565a160/docs/images/hotkeys-ingame.jpg)

The screenshots come from native PID7852, frozen6a952f9. This preview differs
only in build.json; every other installed byte is identical. The18-row editor
uses the original recessed field background, live search, aligned top controls
and a shared footer for Reset/Apply/Cancel and the counter. Redundant Change/Clear
buttons and idle explanatory lines are removed. Click a row or press Enter to
capture; Delete clears its binding. Search narrowed live to32 group actions;
Enter capture, Ctrl+F11, Delete, Reset and Cancel passed the bounded native check.
No test edits were saved. Error log header-only; desktop released05:12:33CEST.
Earlier PID13032 verified Apply/reopen persistence and conflict handling.
See the [native receipt](https://github.com/Krarilotus/extension-custom-hotkeys/blob/f67fc6d9779f8ffe12b6ebd72462f317a565a160/docs/editor-0.1.1-evidence.md).

![Retained native group shortcuts](https://raw.githubusercontent.com/Krarilotus/extension-custom-hotkeys/f67fc6d9779f8ffe12b6ebd72462f317a565a160/docs/images/hotkeys-groups-ingame.jpg)

This is bounded native evidence, not a complete keyboard-only acceptance pass.

Pending before acceptance: mouse rebinding, building control groups, camera
bookmarks, full economy/recruitment/targeting/grid workflows, text/focus/held-key
regressions, all game languages/layouts/minimum resolution, native command counts
and1100-speed performance. Multiplayer remains gated pending the user's physical
two-peer tests; replay/state restoration requires the Recorder owner's lifecycle
API and integration acceptance. No approved merge or release is claimed.

Descriptions are supplied for en/de/fr/es/hu/tr/ru/ch/fa and use the launcher
language. The editor independently uses `data.version.getGameLanguage()` after
game initialization. The stock API's seven language values are covered by the
in-game catalogs; other patched languages/fonts need their own verified support.
