# Tunnelers and engineers: single-player test bundle

## TL;DR

This bundle includes **AI Swapper1.5.0** and **Unit Behaviour Fixes0.1.0**, with their UCP signatures. Starting tunnelers use native keep-defense placement. Idle tunnelers can respond to nearby enemies according to their group stance. Siege crew cleanup and dismount identity checks reuse the original crew records, preserving surviving engineers' identity and health.

Both unit fix switches default **ON** when the module is selected. Extra starting troop counts remain zero unless configured. Options and descriptions cover all nine UCP frontend languages. **Recruitment accounting is still unfinished. This is a test candidate, not the completed release.** Runtime-error localization, GUI acceptance and the full native lifecycle/compatibility review also remain open.

[Store PR42, targeting3.0.7](https://github.com/UnofficialCrusaderPatch/UCP3-extensions-store/pull/42) links the latest download. Sources: [AI Swapper PR20](https://github.com/UnofficialCrusaderPatch/extension-aiSwapper/pull/20), commit26e1b1f0bb7f22ee3e3ac947f0c3f01d95218082; [unit fixes PR2](https://github.com/Krarilotus/ucp3-fixes/pull/2), commita29738adab7e62f216446daebb1adb1fc1b2b57a. Use SHA256SUMS.txt to distinguish this bundle from older previews with the same module version.

## Install

1. Use a separate **UCP3.0.7** test installation. Preserve its existing configuration. Install AI Swapper and its existing dependencies through Content first.
2. Extract this outer bundle. Copy all four files from `modules` into the game's **`ucp/modules`**: both inner module ZIPs and their `.zip.sig` files. Keep the inner ZIPs intact. These are signed module packages; no security bypass is required.
3. Select **AI Swapper1.5.0** and **Unit Behaviour Fixes0.1.0** in the GUI. In Customizations, leave **Siege crew cleanup** ON under **Bugfixes** and **Tunneler combat response** ON under **AI / Fixes**. Apply and restart the game after changing a switch.

## Short tests

- **Starting troops:** Customizations > AI Swapper > Open Menu. Select Wolf, enable Starting troops, enter3 in Starting tunnelers / Normal game, then Save and Close and Apply. Start a new single-player Normal skirmish with centered starting advantage. Each Wolf should receive3 additional tunnelers in native keep-defense placement. Other starting troops should retain their configured counts. Save/load must not add another batch; restart should create the configured count once.
- **Nearby defense:** use an AI with tunnelers in an ordinary attacking troop slot. Bring hostile troops within the group's response range. Idle tunnelers should use the same stance-controlled response as ordinary melee troops. Hold stance should not initiate pursuit. Also try a tunneling order and report any interruption. No new AIV row is added; AI: AIV Troop Behaviour0.2.3 and AIC Loader1.1.2 retain their configuration owners.
- **Siege crews:** mount injured engineers, then dismount: survivors should retain their health. Destroy a crewed siege engine: its original crew should not remain as living hidden engineers. These checks still need wider player feedback; the component evidence is described below.
- **Compare/restore:** turn either fix OFF and restart for original behavior. Set extra tunnelers to0 to disable that addition, or clear the field to inherit the AI pack. Crusader and Deathmatch have separate starting counts. Older preview saves keep their existing roles; test placement using a new match or restart.

## What was checked

AI Swapper's corrected starting-defense path has original-instruction checks on six local/EFIGS/Polish SHC/Extreme fixtures. The corrected signed AI-only package also passed Polish SHC/Extreme load, restart and identity/group preservation checks. Earlier versions' gameplay evidence is not silently attributed to this combined bundle.

Unit fixes have focused original-instruction checks for crew death/fire, dismount UID/bounds/health, and idle enemy response with original native callees. The new dismount candidate preserves the complete native unit pool for valid partial/full crews and performs no writes to a reused crew record. Binding checks reject missing/ambiguous/occupied/changed contexts. The package's33 repository tests passed. Native Polish SHC/Extreme crew observations and Polish SHC idle flag installation were performed on earlier unit candidates; **the final combined signed bundle has not yet been run in-game**.

Remaining code work includes role-specific recruitment accounting coordinated with AIC Tactics PRs12/16/17. Additional lifecycle/casualty, idle-to-work transition, save/restore, composition, GUI and performance acceptance is recorded in the source PRs. Starting-troop discovery currently adds roughly18-22seconds in measured positive setups; no per-frame scan or census is added. Following the user's latest direction, remaining worker testing stays focused rather than repeating broad gameplay rounds.

Multiplayer testing belongs to players and was not performed by this worker. Report game/module versions, settings, expected/actual behavior and a reproducing save.
