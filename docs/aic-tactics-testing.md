# AIC Tactics test bundle

**TL;DR:** Test AIC Tactics 0.0.17 with normal UCP 3.0.7. Extract the outer bundle once; keep the inner module ZIPs zipped.

Copy this bundle's `ucp/modules` contents into your game's `ucp/modules`, keeping every module ZIP zipped and its `.zip.sig` beside it; enable AIC Tactics in the UCP GUI and apply `AIC-TACTICS-COMPATIBILITY.md`.
Merge an example fragment into the `aic` object of a copied personality and start a new game. New recruitment, target and raid policies apply only to personalities that opt in; the engineer-counting and safe-placement fixes have default-ON module switches.
For multiplayer, all peers must use the same bundle and configuration.

No development runtime or newer scanner is required.

This bundle includes GPL-3.0 licenses in AIC Tactics 0.0.17 and Files 1.4.2.
Map Extensions remains 1.1.4 for explicit map/load context and rejected-load
handling. Start a new match; old preview saves
and replays require their original package versions.

Module ZIPs use the existing UCP store signatures. The outer bundle is only a container: extract it once, then copy the inner ZIPs and signatures. Do not put the outer ZIP in the modules folder.

For the eight-player Ascension Green Haven spectator fixture, use Vanilla Interpretation Castles and pair allies by their actual neighboring map positions. Compare an untouched personality against an opted-in Wolf or Saladin. Report the executable version, personality/configuration and observed behavior on [AIC Tactics PR #30](https://github.com/UnofficialCrusaderPatch/extension-aic-tactics/pull/30).

The bundle contains AIC Tactics and its existing required dependencies: AIC Loader (personality settings), UCP2 Legacy (compatibility options), Map Extensions (save state), Protocol (multiplayer settings checks), Chat (local status messages), and Files (used by Protocol). Recorder is separate; install it only for replay testing. `SHA256SUMS.txt` and `store-manifest.yml` identify the exact module files and source revisions. Report findings on [AIC Tactics PR #30](https://github.com/UnofficialCrusaderPatch/extension-aic-tactics/pull/30). Gameplay, replay and measured performance acceptance for 0.0.17 are pending; multiplayer testing belongs to players.
