# Custom Hotkeys 0.1.4 — integration tester build

**TL;DR:** Rebind keys in-game, save profiles and try Game Default, Modern RTS or
Grid. Activate the module and press **F12**. Multiplayer and Recorder combinations
are open for testing; Hotkeys no longer requires a particular Recorder API or
blocks input because Recorder reports playback.

[Download Custom Hotkeys 0.1.4](custom-hotkeys-0.1.4.zip?raw=true).
Recorder is optional; the [Recorder 0.50.4 preview](recorder-integration/recorder-0.50.4.zip?raw=true)
used in the paired tests is also available. Older Recorder APIs no longer prevent
Hotkeys startup. Optional lifecycle notifications still release old held keys at
world transitions, then fresh input can be used again.

Install the ZIP in `ucp/modules` in a test installation and select its new version
in UCP. SHC1.41, UCP3.0.7+, UI1.0.1, LuaJIT/cffi/winProcHandler1.0.0 and
graphicsApiReplacer1.3.0. Automarket tests use Automarket1.1.0 with protocol and
map-extensions1.0.0. Legacy is optional and its known conflicting `o_keys.enabled`
option is required false. There is no second launcher activation switch.

This unsigned development build intentionally removes Hotkeys' playback input
lock. Existing native control availability, text focus and game save/load rules
still define the actions. Report interactions with Recorder, Automarket and
multiplayer, including duplicate commands, unexpected actions and desynchronization.

Missing features (mouse rebinding, building groups, camera bookmarks) and remaining
native acceptance are still development work, not hidden test switches. Nothing
here claims complete keyboard control, two-peer synchronization, or a merged release.

Validation: 486 component tests on Lua5.4/LuaJIT; 42 affected localized metadata
and module checks re-run after the description update; source CI green. All nine
Store descriptions updated. Reproducible ZIP: 88744 bytes, SHA256
`e34eb581d9d6246016846f7280346c6a50d133d5a480b3632894155512fc95f9`, source `319ccf0b27bf574ffb755153af901acc0dc494e5`.

Native exact-ZIP check (PID25780): loaded with Recorder0.50.4 and Automarket1.1.0;
F12 opened the editor both while recording and during playback of a fresh0.1.4
recording. Cancel returned to playback at1166/2169 ticks with matching HUD checks.
No world commands were submitted in this check, and playback was exited before
completion. Header-only error log; normal exit/PID absence verified, baseline
config/profiles restored and desktop released07:55:01 CEST.

[Evidence and limits](https://github.com/Krarilotus/extension-custom-hotkeys/blob/e27bdcbf0e82ed0a33be6c521256d3540014d78d/docs/unrestricted-preview.md).

![Actual 0.1.4 in-game editor](https://raw.githubusercontent.com/Krarilotus/extension-custom-hotkeys/e27bdcbf0e82ed0a33be6c521256d3540014d78d/docs/images/hotkeys-014-recording.png)


Previous immutable payloads are preserved: [0.1.3](custom-hotkeys-0.1.3.zip?raw=true),
[0.1.2](recorder-integration/custom-hotkeys-0.1.2.zip?raw=true),
[0.1.1](custom-hotkeys-0.1.1.zip?raw=true). Their gating/evidence descriptions refer
to those versions, not 0.1.4.
