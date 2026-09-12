# Custom Hotkeys 0.1.3 test preview

**TL;DR:** Multiplayer testing is now enabled. Rebind in-game, save profiles and
try Game Default, Modern RTS or Grid. Activate the module and press **F12**;
there is no extra launcher switch. Select **Apply** to save changes.

Download [Custom Hotkeys 0.1.3](custom-hotkeys-0.1.3.zip?raw=true).
For Recorder testing, also install the paired
[Recorder 0.50.4 preview](recorder-integration/recorder-0.50.4.zip?raw=true).
Recorder is optional. Older Recorder versions lack the required input lifecycle
API; use the paired ZIP to test recording, playback and Automarket together.

Install ZIPs in `ucp/modules` in a separate test installation and select the new
versions in UCP. SHC 1.41, UCP 3.0.7+, UI 1.0.1, LuaJIT/cffi/winProcHandler 1.0.0
and graphicsApiReplacer 1.3.0 are required. Automarket testing uses Automarket
1.1.0, protocol 1.0.0 and map-extensions 1.0.0.

Legacy is not a dependency. When present, its conflicting `o_keys.enabled` is
required false and checked before activation. Restart after changing modules.
Replay live-action protection, text/modal/focus checks and native multiplayer
save/load restrictions remain active. Use the game's normal multiplayer
save/load controls; the custom SP quickslot workflow is not a network load path.

All nine Store descriptions have updated localized summaries and instructions.
All game catalogs pass complete key coverage without English fallback. Native
building/control names still come from the game. Fluent/native language review
and two-PC synchronization acceptance remain pending.

These ZIPs are unsigned development previews for testing, not an accepted Store
release. No multiplayer pass, complete keyboard workflow or verified merge is
claimed. See the [test checklist](https://github.com/Krarilotus/extension-custom-hotkeys/blob/feat/binding-core/docs/manual-multiplayer.md)
and [earlier bounded SP Recorder evidence](recorder-integration/README.md).

Source: `7c1421183bb14d8a188360b630c2ab89f7a0d83b`.
Hotkeys: 89,426 bytes; SHA-256
`fff2f759044beff01f078ceb7add5ec364b15cf83f71669e0085d244374ccbfe`.
Two builds are byte-identical; 486 component tests pass in Lua 5.4/LuaJIT.
Recorder: 917,998 bytes; SHA-256
`1e8511e91002ed36a1928b8c621d2215a7e343582121a069e51b9b1b33e8046c`.

Previous immutable payloads remain available: [0.1.1](custom-hotkeys-0.1.1.zip?raw=true)
rejects Recorder; [0.1.2](recorder-integration/custom-hotkeys-0.1.2.zip?raw=true)
has Recorder integration but blocks multiplayer input.

Native 0.1.3 check: PID2772 loaded with the paired Recorder and Automarket,
F12 opened the 211-action editor, Cancel closed it and normal exit succeeded.
Error log contains headers only. [Exact evidence and limits](https://github.com/Krarilotus/extension-custom-hotkeys/blob/b5996268ab677fb054715fba4579908d13671cf5/docs/multiplayer-preview.md).

![Actual 0.1.3 editor](https://raw.githubusercontent.com/Krarilotus/extension-custom-hotkeys/b5996268ab677fb054715fba4579908d13671cf5/docs/images/hotkeys-013-editor.png)
