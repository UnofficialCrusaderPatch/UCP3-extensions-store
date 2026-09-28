# AIC Tactics 0.0.16 test bundle

**TL;DR:** Keep the seven signed module ZIPs zipped, install their `.sig` files beside them, enable AIC Tactics in UCP 3.0.7, and start a new match. The previous 0.0.14 bundle cold-loaded an attack in progress on Extreme; the updated siege behavior still needs live testing.

Copy `ucp/modules/*` into the game's `ucp/modules` folder, then enable AIC Tactics in the UCP GUI. In a copied AI personality's `aic` object, try `"LargerSiegeForces": true`, `"SiegeForceMax": 10`, `"SafeSiegePlacement": true`, `"ActualSiegeResourcePayment": true` and `"CoordinatedSiegeHarassment": true`; give a neighboring AI explicit `false` for the larger-force and harassment switches. Compare equipment, crew survival and stock/gold, then watch whether harassment engines keep range and fire. Test a crowded siege site, a resource shortage and save/load during an attack; report the game version and observations on [PR #27](https://github.com/UnofficialCrusaderPatch/extension-aic-tactics/pull/27).

The five siege and engineer controls are independent; an omitted AIC field inherits its module fallback. `SiegeForceMax: 0` keeps one native batch, and the existing `SiegeEngine1..8` entries determine the equipment mix. The bundle includes AIC Tactics and its six required dependencies; Fixed Engineers 0.2.0 is a separate general lifecycle fix, and Recorder is optional for replay checks. Old preview saves and replays need their original module versions.

All peers in multiplayer must install the same signed ZIPs and configuration. Module ZIPs have Store signatures; the outer download ZIP is only a container. `SHA256SUMS.txt` records the exact files.
