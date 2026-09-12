# Custom Hotkeys 0.1.6

**TL;DR:** Rebind keyboard and mouse controls in-game, save profiles, assign
building groups and camera positions, and try Game Default, Modern RTS or Grid.
Activate the module and press **F12**. Building shortcuts preserve your cursor;
Options and Automarket controls can also be operated with the keyboard.

[Download Custom Hotkeys 0.1.6](custom-hotkeys-0.1.6.zip?raw=true).

Put the ZIP in `ucp/modules`, select this version and activate it. There is no
second activation switch. Requires UCP 3.0.7+, UI 1.0.1, LuaJIT/cffi/
winProcHandler 1.0.0 and graphicsApiReplacer 1.3.0. Legacy is optional; its
conflicting `o_keys.enabled` value is required false by the module configuration.
All nine Store descriptions explain opening the editor and follow the launcher
language. The editor follows the game language.

Ctrl+number assigns a selected owned building or a native unit group; number
recalls it, repeated number focuses it, and Alt+number focuses directly.
Shift+Alt+number saves a local camera position; Ctrl+Alt+number recalls it.
Numpad 8/4/2/6 moves the target, Shift makes fine adjustments, 5 centers,
Enter confirms and Decimal cancels. Profiles from earlier versions keep their
bindings: reset a preset to obtain all new defaults or assign individual actions.

Multiplayer, Recorder and Automarket are open for testing, including playback.
There is no Hotkeys Recorder-version or playback activation lock. Native game
rules, text-field focus and current menu ownership still apply. The optional
[Recorder 0.50.4 preview](recorder-integration/recorder-0.50.4.zip?raw=true) is unchanged.

Validation: **571 component tests**, **42 localized metadata/module checks**,
and 169 named bindings resolved using UCP utilities with 153 unique patterns in
each local SHC/Extreme 1.41 fixture. Native SHC checks include building groups,
camera recall, Modern selection/orders, keyboard construction/recruitment/trade,
Automarket navigation/Save and Options sliders. A completed Recorder session
replayed all 4 recorded commands with matching resource, RNG and full RNG
checkpoints. See the evidence for exact revisions and scope.

The tested ZIP is reproducible: **101,192 bytes**, SHA256
`0c5a4e59caa0c762a54b064851bd7c1549e6fbd2b42564b4dbe81c9075df2ceb`,
runtime source `97cfe4bf290995fafb2f30846e3ba6def830d804`.
Recipe source `3053ccb12a75d37654fe34512b9c6a1badc5928e` has identical packaged
source files; subsequent changes only update online descriptions and evidence.

[Feature and native evidence](https://github.com/Krarilotus/extension-custom-hotkeys/blob/3053ccb12a75d37654fe34512b9c6a1badc5928e/docs/features-0.1.6.md)
and [package acceptance receipt](custom-hotkeys-0.1.6.native.json).

![Actual 0.1.6 gameplay editor](https://raw.githubusercontent.com/Krarilotus/extension-custom-hotkeys/4fa5305103d4bdf9467d185da5c382ad7ba24a59/docs/images/hotkeys-016-ingame.png)

This is an unsigned development preview. Two-PC multiplayer is deferred to manual
testing. Full keyboard/text/held/focus acceptance, alternate-profile playback,
state restore, high-speed simulation and additional executable coverage remain
to be verified. The expanded 0.1.6 controls still need an Extreme gameplay rerun.
These are test gaps, not feature activation locks. No completed acceptance or
verified PR merge is claimed.

Earlier immutable downloads remain available:
[0.1.5](custom-hotkeys-0.1.5.zip?raw=true),
[0.1.4](custom-hotkeys-0.1.4.zip?raw=true),
[0.1.3](custom-hotkeys-0.1.3.zip?raw=true),
[0.1.2](recorder-integration/custom-hotkeys-0.1.2.zip?raw=true),
[0.1.1](custom-hotkeys-0.1.1.zip?raw=true).
