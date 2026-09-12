# Custom Hotkeys test preview

This is an **unsigned, incomplete test build**, not the signed Store release.
The Store recipe is a draft proposal; do not publish it before the implementation
and required acceptance gates in the linked extension PR are complete.

Download [custom-hotkeys-0.1.0.zip](custom-hotkeys-0.1.0.zip?raw=true).
Source: `c7e3b450159cbef4eedb88ca4eed946190ea6ec8` in
[extension-custom-hotkeys](https://github.com/Krarilotus/extension-custom-hotkeys/tree/c7e3b450159cbef4eedb88ca4eed946190ea6ec8).
Size:85,862 bytes. SHA-256:
`434ddc9b0412cd54bbea220c4c7be0479ed9a31a285e5e5b56a47f4ed98feeab`.
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

![Actual in-game hotkey editor](https://raw.githubusercontent.com/Krarilotus/extension-custom-hotkeys/e27b392f32ca8cd3d3dd33b31a641451cfa23a6f/docs/images/hotkeys-ingame.jpg)

The screenshot comes from native PID16012, frozen18ca42f. The preview contains
identical runtime/configuration/definition bytes; only README and the embedded
commit receipt differ. Main-menu and gameplay editor pages were checked, including
F12, persistent Grid selection, native button text centering and texture surfaces.
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
