# Interface and Visual Fixes 0.1.0

Clearer lobbies, smoother building previews, distinct dead-tree stages, aligned
tower doors with cliff foundations and connected cliff textures. Enable each fix separately and restart
the game. All seven options start disabled. Requires SHC 1.41 and UCP 3.0.7.

| Option | What changes |
| --- | --- |
| Show lobby map descriptions | Custom descriptions remain visible when switching maps in the existing lobby text area. |
| Clear unique-building preview after placement | Successfully placing a marketplace, barracks, mercenary post or guild clears its tool. Failed attempts remain retryable; ordinary buildings and granary expansions retain repeat placement. |
| Show building previews while scrolling | The existing building preview follows camera movement. |
| Distinguish dead tree stages | Standing-dead trees retain their distinct artwork before becoming fallen logs. |
| Align tower doors with connecting walls | Each side chooses the highest eligible connection, then the nearest to its centre among ties. The door follows the join horizontally and vertically. Outermost joins place it half a tile inward. Exposed tower foundations use existing wall masonry, backing doors at lower connection heights. AI stair6 alone supplies a ground door; raised stairs do not. |
| Show single-player lobby Load | The existing Load control fits between the portrait and Start, including a lobby without AI opponents. |
| Continue cliff textures after rotation | Textures advance along both cliff faces in all four map orientations, using the current texture pack. |

An exact tower-connection tie uses fixed native boundary order. A higher
off-centre connection wins over a lower centred one. This is a visual correction;
it does not change tower access, terrain, pathfinding or simulation.

## Native feature screenshots

Map descriptions remain in the existing lobby text area.

![Map descriptions remain in the existing lobby text area.](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/dd442ef9f74454dae10e479543e074a26d82a1f0/docs/native-test-visible-after.png)

The engineers guild is placed and its unique-building preview is cleared.

![The engineers guild is placed and its unique-building preview is cleared.](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/dd442ef9f74454dae10e479543e074a26d82a1f0/docs/native-engineers-cleared.png)

The existing building preview remains visible during camera scrolling.

![The existing building preview remains visible during camera scrolling.](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/dd442ef9f74454dae10e479543e074a26d82a1f0/docs/native-patched-scrolling-visible.png)

Standing-dead trees use their distinct existing artwork.

![Standing-dead trees use their distinct existing artwork.](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/dd442ef9f74454dae10e479543e074a26d82a1f0/docs/native-trees-guard-standing.png)

The foreground square tower selects the nearer of two equally high walls.

![The foreground square tower selects the nearer of two equally high walls.](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/dd442ef9f74454dae10e479543e074a26d82a1f0/docs/r023/nearer-high.png)

After removing that wall, the remaining high wall wins despite the nearer low wall. The camera moved between captures.

![After removing that wall, the remaining high wall wins despite the nearer low wall. The camera moved between captures.](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/dd442ef9f74454dae10e479543e074a26d82a1f0/docs/r023/farther-high.png)

The outermost high connection places its door half a tile inward from the corner.

![The outermost high connection places its door half a tile inward from the corner.](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/dd442ef9f74454dae10e479543e074a26d82a1f0/docs/r023/review-edge.png)

The AI built these towers and stairs: stair6 supplies the left ground door; the raised stair on the right supplies none.

![The AI built these towers and stairs: stair6 supplies the left ground door; the raised stair on the right supplies none.](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/dd442ef9f74454dae10e479543e074a26d82a1f0/docs/r023/native-ai-stairs.png)

Masonry extends beneath the cliff-edge tower. The lower high and low walls each supply a door at their own height.

![Masonry extends beneath the cliff-edge tower. The lower high and low walls each supply a door at their own height.](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/dd442ef9f74454dae10e479543e074a26d82a1f0/docs/r023/foundations/rotation-0.png)

The AI built both elevated towers and stairs: stair6 alone supplies the left foundation door at ground level; the raised stair on the right supplies none.

![The AI built both elevated towers and stairs: stair6 alone supplies the left foundation door at ground level; the raised stair on the right supplies none.](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/dd442ef9f74454dae10e479543e074a26d82a1f0/docs/r023/foundations/ai-stair6.png)

The single-player lobby Load control fits at 800x600.

![The single-player lobby Load control fits at 800x600.](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/dd442ef9f74454dae10e479543e074a26d82a1f0/docs/r001/lobby-800.png)

Before the cliff fix: a quarter turn repeats one texture strip along a face.

![Before the cliff fix: a quarter turn repeats one texture strip along a face.](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/dd442ef9f74454dae10e479543e074a26d82a1f0/docs/cliffs/before-6.png)

After the cliff fix: the same face advances through the existing texture.

![After the cliff fix: the same face advances through the existing texture.](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/dd442ef9f74454dae10e479543e074a26d82a1f0/docs/cliffs/after-6.png)

## Validation and discovery metadata

The recipe pins merged extension commit `dd442ef9f74454dae10e479543e074a26d82a1f0`. The feature and follow-up
PRs are merged, with their owning issues resolved. The package passes 925 combined
tests and all nine GUI locale checks; validation files distinguish native,
original-code and automated evidence. MP, Extreme and replay are not certified.

Tower selection reuses the original connection refresh. Warm drawing reads its
cache without scanning walls: the native component benchmark added 0.0256 ms per
1,000 synthetic tower draws and 0.1919 ms per 1,000 connection refreshes, on the
unchanged 40-update cadence. Tower masonry adds about 5.9 ns per existing
graphics tile refresh, with no new drawing pass. Cliff selection replaces an existing calculation
in place, adding no allocation, hook or frame-render work. Its measured median
added cost stayed below 1 ms per million refresh calls. These are component
measurements, not full-game FPS or a literal 1,000-speed menu setting.

Canonical tags are `bugfixes` and `interface`. The built module includes flat
`tags.<id>` labels in all nine locales. The same archive-derived labels are
included in this recipe's `contents.tag-locales`, so the new discovery feature
can search them before installation. Translations remain labels, not new IDs.
See [the label table](interface-visual-fixes-tags.md).

This follows the package/Store contract in
[GUI PR #382](https://github.com/UnofficialCrusaderPatch/UCP3-GUI/pull/382) and
[Store PR #33](https://github.com/UnofficialCrusaderPatch/UCP3-extensions-store/pull/33).
The recipe supplies its own labels without depending on the general extractor
being merged. Existing GUIs can read the additive metadata; tag filtering and
translated tag search require the discovery update. Derived code/options/type
facts are not duplicated as authored topic tags.

Store signing and publication run through the normal release workflow after merge.
The Store and UCP wiki contain the same condensed changelog entry.
