# AIC Tactics test bundle

**TL;DR:** Use normal UCP 3.0.7. Extract the outer bundle once; keep the inner module ZIPs zipped.

Copy this bundle's `ucp/modules` contents into your game's `ucp/modules`, keeping every module ZIP zipped and its `.zip.sig` beside it; enable AIC Tactics in the UCP GUI and apply `AIC-TACTICS-COMPATIBILITY.md`.
Merge an example fragment into the `aic` object of a copied personality and start a new game; recruitment weights, stable attack targets, next-wave reserves and split raids only change for personalities that opt in.
For replay checks, also enable the included Recorder; ordinary saves do not need it, and all multiplayer peers must use the same bundle and configuration.

No development runtime or newer scanner is required.

This bundle updates AIC Tactics to 0.0.8 and Map Extensions to 1.1.2 for the
configuration-order and rejected-load fixes. Start a new match; old preview saves
and replays require their original package versions.

Module ZIPs use the existing UCP store signatures. The outer bundle is only a container: extract it once, then copy the inner ZIPs and signatures. Do not put the outer ZIP in the modules folder.

For the eight-player Ascension Green Haven spectator fixture, use Vanilla Interpretation Castles and pair allies by their actual neighboring map positions. Compare an untouched personality against an opted-in Wolf or Saladin. Report the executable version, personality/configuration and observed behavior on [AIC Tactics PR17](https://github.com/UnofficialCrusaderPatch/extension-aic-tactics/pull/17).

Recorder and its UI, LuaJIT, cffi and WinProc Handler dependencies are included for convenience; recording is optional. `SHA256SUMS.txt` and `store-manifest.yml` identify the exact module files and source revisions. Current acceptance evidence is maintained in PR17; this preview does not claim the remaining multiplayer, replay or performance gates have passed.
