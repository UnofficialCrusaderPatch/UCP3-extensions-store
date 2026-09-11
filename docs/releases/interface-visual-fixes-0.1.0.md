# Interface and Visual Fixes 0.1.0

This module adds individually selectable fixes to the game's existing interface
and graphics. Each option starts disabled and takes effect after a game restart.
The supported game is Stronghold Crusader 1.41 with UCP 3.0.7.

| Option | What changes |
| --- | --- |
| Show lobby map descriptions | Custom map descriptions remain visible when switching between custom and shipped maps in the existing lobby text area. |
| Clear unique-building preview after placement | Successfully placing a marketplace, barracks, mercenary post or guild clears its tool. Failed placement can be retried, and ordinary buildings remain available for repeated placement. |
| Show building previews while scrolling | The existing building preview follows camera movement. |
| Distinguish dead tree stages | Standing dead trees use the game's existing standing-dead art before becoming fallen logs. |
| Align tower doors with connecting walls | Each side chooses its highest connected wall, then the nearest connection to the side centre among equally high walls. The existing doorway moves along the face and vertically to the chosen join. A higher off-centre wall wins over a lower centred wall; an exact tie uses fixed native boundary order. |
| Show single-player lobby Load | The existing Load control is visible and usable in a human-only skirmish lobby, positioned between the portrait and Start control. |

The recipe pins merged extension commit528f3ce1022986d8e66d9fd6f155b6bfd4be8fc0.
All six focused feature PRs and the shared integration PR are merged, with their
owning issues resolved and final CI checks passing. This submission targets the
store's3.0.7 branch. Store publication/signing remains with its normal release
workflow; no release has been published by this task.

## Native feature screenshots

Lobby map descriptions use the existing text area:

![Custom map description visible](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/528f3ce1022986d8e66d9fd6f155b6bfd4be8fc0/docs/native-test-visible-after.png)

A successfully placed engineers guild clears the unique-building preview:

![Guild placed and preview cleared](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/528f3ce1022986d8e66d9fd6f155b6bfd4be8fc0/docs/native-engineers-cleared.png)

The existing building preview remains visible while the camera scrolls:

![Preview during camera scrolling](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/528f3ce1022986d8e66d9fd6f155b6bfd4be8fc0/docs/native-patched-scrolling-visible.png)

Standing-dead trees use their existing distinct art:

![Standing dead trees](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/528f3ce1022986d8e66d9fd6f155b6bfd4be8fc0/docs/native-trees-guard-standing.png)

The foreground square tower selects the nearer of two equally high connections:

![Nearer high wall selected](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/528f3ce1022986d8e66d9fd6f155b6bfd4be8fc0/docs/r023/nearer-high.png)

After removing that wall, its doorway follows the remaining off-centre high
connection despite the nearer low wall. The camera moved between captures.

![Remaining high wall selected](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/528f3ce1022986d8e66d9fd6f155b6bfd4be8fc0/docs/r023/farther-high.png)

The single-player Load control fits between the portrait and Start at800x600:

![Native lobby Load](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/528f3ce1022986d8e66d9fd6f155b6bfd4be8fc0/docs/r001/lobby-800.png)

733 combined automated tests pass; individual validation files describe native
acceptance and its limits. The tower selection uses the original connection
refresh. Warm drawing reads its cache without wall scans. A native component
benchmark added0.0401ms per1000 synthetic tower draws and0.140ms per1000 connection
refreshes, which occur once per40 tower updates. This is not a whole-game FPS
or literal1000-speed setting claim. MP, Extreme and replay are not certified.

## Discovery tags and translations

The module authors the canonical IDs `bugfixes` and `interface` in its
`definition.yml`. The store builder imports that definition from the pinned
source, so the same metadata reaches installed packages and the store catalog.
The GUI supplies translated display labels using `discovery.tag.bugfixes` and
`discovery.tag.interface`; translated strings are not separate tag IDs.

The implementation contract is [GUI PR382](https://github.com/UnofficialCrusaderPatch/UCP3-GUI/pull/382),
checked atff683b95e1cf844d2b3babcf4382f9d422a4d340 on11September2026 (still open).
Its existing `module`, `code` and `options` capability labels are derived by the
GUI. The module does not duplicate these facts as authored topic tags.

See [the locale label table](interface-visual-fixes-tags.md) for the maintained
translations. Existing GUIs can still read the additive module metadata; the
new tag filtering UI requires the discovery update.
