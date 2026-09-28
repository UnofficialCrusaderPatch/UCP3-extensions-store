# AIC Tactics test bundle

**TL;DR:** On UCP 3.0.7, copy the signed inner module ZIPs and `.sig` files into `ucp/modules`, enable AIC Tactics, then start a fresh match. This is a test candidate, not a completed release.

Copy this bundle's `ucp/modules` contents into your game's `ucp/modules`, keeping every module ZIP zipped and its `.zip.sig` beside it; enable AIC Tactics in the UCP GUI and apply `AIC-TACTICS-COMPATIBILITY.md`.
Merge an example fragment into the `aic` object of a copied personality and start a new game; recruitment weights, stable attack targets, next-wave reserves and split raids only change for personalities that opt in.
For the siege check, give two copied AIs opposite `CoordinatedSiegeHarassment` values. Set the enabled AI's `SiegeHarassMinEngines` to 3 and `HarassingSiegeEnginesMax` to 10, then watch whether its catapults/fire ballistas gather and move together while the other AI retains native movement. Try `SafeSiegePlacement: true` at a crowded guild and `ActualSiegeResourcePayment: true` with scarce resources; compare survival, construction, stock and gold. Report results on [siege PR25](https://github.com/UnofficialCrusaderPatch/extension-aic-tactics/pull/25).
For multiplayer, all peers must use the same bundle and configuration.

No development runtime or newer scanner is required.

This bundle includes GPL-3.0 licenses in AIC Tactics 0.0.12 and Files 1.4.2.
Map Extensions remains 1.1.4 for explicit map/load context and rejected-load
handling. Start a new match; old preview saves
and replays require their original package versions.

Module ZIPs use the existing UCP store signatures. The outer bundle is only a container.

For the eight-player Ascension Green Haven spectator fixture, use Vanilla Interpretation Castles and pair allies by their actual neighboring map positions. Compare an untouched personality against an opted-in Wolf or Saladin. Report the executable version, personality/configuration and observed behavior on [AIC Tactics PR17](https://github.com/UnofficialCrusaderPatch/extension-aic-tactics/pull/17).

The bundle contains AIC Tactics and its six dependencies. Recorder is optional and is installed separately for replay tests. `SHA256SUMS.txt` identifies exact files. The independent larger main-assault policy and live siege acceptance remain open; multiplayer testing belongs to players.
