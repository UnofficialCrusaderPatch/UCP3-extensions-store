# Recorder integration preview

**TL;DR:** Hotkeys 0.1.2 can coexist with the accompanying Recorder 0.50.4
development build. A native single-player recording with Automarket 1.1.0
replayed all four commands with matching resource/RNG/full-RNG checkpoints.
This is bounded evidence, not complete Hotkeys acceptance or multiplayer support.

Download both unsigned development modules:

* [Custom Hotkeys 0.1.2](custom-hotkeys-0.1.2.zip?raw=true), 89,170 bytes,
  SHA-256 `e51e7174e7c58b8142d8b4b19ccdcae347d6b250b9fa0877ca3e408cda091dbf`.
* [Recorder 0.50.4](recorder-0.50.4.zip?raw=true), 917,998 bytes,
  SHA-256 `1e8511e91002ed36a1928b8c621d2215a7e343582121a069e51b9b1b33e8046c`.

Use an isolated SHC 1.41 / UCP 3.0.7 installation with the declared Hotkeys
dependencies. Activate these exact module versions. Recorder remains optional;
Recorder 0.50.3 lacks the required API. The existing Hotkeys 0.1.1 download still
rejects Recorder. No published archive or Store Recorder recipe is replaced here.
The expected unsigned-development notice remains enabled.

The combined native check additionally used Automarket 1.1.0, protocol 1.0.0 and
map-extensions 1.0.0. Recorder auto-record and fixed seed 1 were enabled; diagnostic
hooks were disabled. Legacy was absent. When present, Legacy's hotkey option is
required off by Hotkeys configuration and checked again before activation.

Hotkeys starts when its module is active. Open the editor with **F12** in a
supported menu or live single-player game; **Apply** persists edits. During
Recorder playback, custom input is blocked, including pause, finish and restore.
Recorder retains all simulation/load/replay ownership.

The [native evidence](https://github.com/Krarilotus/extension-custom-hotkeys/blob/702b7b274c6ab4ae3594820b16cb01b152557620/docs/recorder-integration.md)
includes a four-command journal and playback receipt: one market placement,
one Automarket policy commit, two native selection commands. The automatic sale
reproduced 8 wood and 2087 gold. A separate zero-command recording covered
backward restore and paused input suppression.

![Actual finished native playback](https://raw.githubusercontent.com/Krarilotus/extension-custom-hotkeys/702b7b274c6ab4ae3594820b16cb01b152557620/docs/images/recorder-automarket-finished.png)

Remaining integration checks: held-key restore, different local profiles between
recording/playback, command-bearing backward restore, and editor search/rebinding
in this exact combination. The native attempt to enter the search field did not
complete; whether this is input injection or an editor interaction is unresolved.
Live multiplayer remains gated, with the physical two-peer test deferred to the
user. Full keyboard-only coverage and the parent preview's feature gaps remain.
Do not treat this as clearance for a general tester announcement or normal merge.

Source: [Hotkeys 702b7b2](https://github.com/Krarilotus/extension-custom-hotkeys/tree/702b7b274c6ab4ae3594820b16cb01b152557620)
and [Recorder 8dfb61e](https://github.com/Krarilotus/ucp_recorder/tree/8dfb61e7b44c619d804265da790c452b66245ad9).
Recorder review is [fork PR2](https://github.com/Krarilotus/ucp_recorder/pull/2),
stacked on [upstream PR46](https://github.com/Corax34/ucp_recorder/pull/46), with
[upstream issue48](https://github.com/Corax34/ucp_recorder/issues/48).
See [native and final package hashes](native-build.json). The final Hotkeys
archive differs from the tested archive only in `build.json`; all runtime bytes
are identical. Two final builds were byte-identical. No approved merge is claimed.
