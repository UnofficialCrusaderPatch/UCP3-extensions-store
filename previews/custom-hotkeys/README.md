# Custom Hotkeys 0.1.5 — native binding and construction fixes

**TL;DR:** Rebind keys in-game, save profiles and try Game Default, Modern RTS or
Grid. Activate the module and press **F12**. Building and Grid shortcuts now keep
your map cursor in place. UCP byte-pattern discovery replaces the executable
hash lock, with native checks on both Crusader and Extreme1.41.

[Download Custom Hotkeys 0.1.5](custom-hotkeys-0.1.5.zip?raw=true).

Put the ZIP in `ucp/modules`, select the new version and activate it. There is
no second activation switch. Requires UCP3.0.7+, UI1.0.1, LuaJIT/cffi/
winProcHandler1.0.0 and graphicsApiReplacer1.3.0. Legacy is optional and its
conflicting `o_keys.enabled` setting is required false automatically.

Multiplayer, Recorder and Automarket remain open for testing, including playback;
no Hotkeys Recorder-version or playback lock is restored. The optional
[Recorder0.50.4 preview](recorder-integration/recorder-0.50.4.zip?raw=true) is
unchanged. Native game control availability, text focus and input ownership apply.

The implementation reuses UCP scanning/caching, UI exports, winProcHandler and
the original enabled button callbacks. Building selection no longer moves the
mouse or fabricates a click. Actual placement uses the normal native command path.
Extreme's larger selection arrays and nonblocking tactical-powers HUD are handled.

Validation: **515 component tests** on Lua5.4/LuaJIT; all nine Store languages
updated. Native Crusader and Extreme checks verified category/building selection
without cursor/camera movement and normal woodcutter placement. F12 opened the
editor in gameplay. Recorder0.50.4 and Automarket1.1.0 were loaded. The exact
Extreme-tested ZIP is reproducible: 94,158 bytes, SHA256
`5fabd7777d246aaf61ee99bc92a9b949e992a87723073fa23c6cef972258fe40`, runtime source `f4f56ec7d3eb6138c8359d6c20b55d31fc5d1e1e`.
Later metadata source `84ffa791d0e95771e37dfdc2689e328b9941aa2b` has identical packaged source files.

[Evidence, reuse inventory and limits](https://github.com/Krarilotus/extension-custom-hotkeys/blob/84ffa791d0e95771e37dfdc2689e328b9941aa2b/docs/native-bindings.md).

![Actual Extreme gameplay editor](https://raw.githubusercontent.com/Krarilotus/extension-custom-hotkeys/4f5932ec3be14c1b3d6d9daf0ace7e5cf5c2e549/docs/images/hotkeys-015-extreme-ingame.png)

This is an unsigned development preview. Mouse rebinding, building groups,
camera bookmarks and complete keyboard workflows remain implementation work.
Two-peer multiplayer, full replay/state-restore, command-count and high-speed
acceptance remain outstanding. Other executable variants require testing.
No full feature completion or verified merge is claimed.

Earlier immutable downloads remain available:
[0.1.4](custom-hotkeys-0.1.4.zip?raw=true),
[0.1.3](custom-hotkeys-0.1.3.zip?raw=true),
[0.1.2](recorder-integration/custom-hotkeys-0.1.2.zip?raw=true),
[0.1.1](custom-hotkeys-0.1.1.zip?raw=true).
