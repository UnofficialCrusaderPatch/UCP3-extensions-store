# Custom Hotkeys 0.1.7

**TL;DR:** Rebind keyboard and mouse controls in-game, save profiles, assign
building groups and camera positions, and try Game Default, Modern RTS or Grid.
Activate the module and press **F12**. Building shortcuts preserve your cursor.
0.1.7 fixes the lingering world tooltip, reduces redundant rendering work, and
adds five missing game-language catalogs with character-safe text layout.

[Download Custom Hotkeys 0.1.7](custom-hotkeys-0.1.7.zip?raw=true).

Put the ZIP in `ucp/modules`, select this version and activate it. No second
activation switch. Requires UCP 3.0.7+, UI 1.0.1, LuaJIT/cffi/winProcHandler 1.0.0
and graphicsApiReplacer 1.3.0. Legacy is optional; conflicting `o_keys.enabled`
is required false by the module configuration. All nine Store descriptions
explain opening the editor. Eleven editor languages follow the loaded game text,
with UCP's game-language setting as fallback.

Ctrl+number assigns a selected owned building or native unit group; number
recalls it, repeated number focuses it, and Alt+number focuses directly.
Shift+Alt+number stores a camera position; Ctrl+Alt+number recalls it.
Numpad 8/4/2/6 moves the target, Shift makes fine adjustments, 5 centers,
Enter confirms and Decimal cancels. Earlier profiles keep their bindings:
reset a preset for new defaults or assign the new actions individually.

Multiplayer, Recorder and Automarket are open for testing, including playback.
No Hotkeys Recorder-version or playback activation lock. Native game rules,
text-field focus and current menu ownership still apply. The optional
[Recorder 0.50.4 preview](recorder-integration/recorder-0.50.4.zip?raw=true) is unchanged.

Validation: **605 component tests**, **34 final locale/metadata checks**, and
171 bindings / 155 unique patterns in each available SHC/Extreme fixture.
The exact ZIP passed native German startup, main-menu and gameplay editor,
keyboard search/text ownership, and Options/Load navigation. Earlier receipts
cover construction, recruitment, trading, groups, targeting, Automarket, Options
sliders, held-camera cancellation and Save-name typing isolation. A prior
Recorder session replayed four commands with matching resource, RNG and full RNG
checkpoints. These are separate runtime receipts, not complete acceptance.

The reproducible ZIP is **112,151 bytes**, SHA256
`0c1d2ff48f45be2a1152363a2983303bd724f39dcccb30c7f15f863585285d98`,
runtime `2ed6d48274261923081b7e9e9e0138b651977c4f`. Recipe source
`2f9a193152ead8c1a591731db152959df3fba5ee` has identical packaged source files.

[Native evidence and scope](https://github.com/Krarilotus/extension-custom-hotkeys/blob/2f9a193152ead8c1a591731db152959df3fba5ee/docs/features-0.1.7.md)
and [package receipt](custom-hotkeys-0.1.7.native.json).

![Actual German 0.1.7 gameplay editor](https://raw.githubusercontent.com/Krarilotus/extension-custom-hotkeys/90f0436c862394b5ae6a9b07945a49261363efe4/docs/images/hotkeys-017-german-ingame.png)

Unsigned development preview. Two-PC multiplayer is deferred to manual testing.
Full keyboard/text/held/focus/mouse acceptance, alternate-profile replay/state
restore, high-speed simulation, expanded Extreme gameplay and additional
executable/font/IME/RTL coverage remain unverified. These are test gaps, not
feature activation locks. No completed acceptance or verified merge is claimed.

Earlier immutable downloads:
[0.1.6](custom-hotkeys-0.1.6.zip?raw=true),
[0.1.5](custom-hotkeys-0.1.5.zip?raw=true),
[0.1.4](custom-hotkeys-0.1.4.zip?raw=true),
[0.1.3](custom-hotkeys-0.1.3.zip?raw=true),
[0.1.2](recorder-integration/custom-hotkeys-0.1.2.zip?raw=true),
[0.1.1](custom-hotkeys-0.1.1.zip?raw=true).
