# AI Swapper 1.5.0: single-player testing

## TL;DR

AI Swapper 1.5.0 adds configurable AI starting tunnelers, with controls in all nine UCP languages. Existing AI packs receive no extra troops by default. Engineer starting troops retain their existing behavior. No recruitment-accounting fix is advertised.

The recipe pins implementation [AI Swapper PR20](https://github.com/UnofficialCrusaderPatch/extension-aiSwapper/pull/20), source `5e8fe70703b00d3987ef10bf199d53b3a5fab3e8`. Release acceptance and signing are still in progress; a public signed download is not yet available. This status must change only after the actual archive is published and verified.

## Short test instructions

After the signed `aiSwapper-1.5.0.zip` is available:

1. Use UCP3.0.7 with AI Swapper's existing dependencies (AIC Loader, AIV Loader, Files, GM Resource Modifier and Text Resource Modifier), normally resolved through the extension store. Install the module ZIP in the test game's `ucp/modules` folder without extracting it. Select AI Swapper1.5.0 in Content and use an AI pack that exposes Starting troops.
2. Open **Customisations > AI Swapper > Open Menu**. Select Wolf, enable the desired AI's **Starting troops** component, and enter **3** under **Starting tunnelers / Normal game**. Save and Close, then Apply.
3. Start a **single-player** Normal skirmish with two Wolves and centered starting advantage. Each Wolf should have three additional tunnelers at the start, with its original other units preserved. Test selection and useful orders/AI use.
4. Save and reload: no additional batch should appear. Restart: each Wolf should begin with the configured count once. Check SHC and Extreme separately.
5. Enter **0** to disable additional tunnelers for a mode. Clear the field to inherit the AI pack. Reset slot removes user overrides. Save/Apply and reopen to check persistence. Crusader and Deathmatch have separate fields; starting advantage scales their counts too.

An AI pack can instead author `Tunneler` in `character.json.startTroops` and must declare an AI Swapper dependency of at least1.5.0. Values are integers0..2499. Required plugin selections stay locked. This capability requires no additional enable switch; absent counts remain zero.

## Performed validation

- Existing helper Release/x86 build, menu build, nine-locale menu/state tests, production configuration import/round-trip/required-lock tests, and diff checks passed.
- Production Lua/PE tests passed on local SHC/Extreme and official Firefly EFIGS/Polish executables. Those tests stub native calls; they do not replace native acceptance.
- Local SHC1.41 and Extreme1.41.1-E native count3/two-Wolf save/load/restart checks passed. Extreme also retained reciprocal native group membership and IDs/UIDs after load; loading a pre-feature save added no units.
- Installed build4 ZIP passed GUI edit/Save/Apply/reopen for Normal7/Crusader1/Deathmatch0, including German and Persian RTL layouts. Both official EFIGS executables consumed the written Normal7 override on restart, with seven-member native groups and original three archers/engineers per Wolf. Earlier count3 saves retained three per Wolf after loading.
- Local build4 ZIP SHA256: `f41f9b78b36d40fccc4780881e09d39c350eed6a5aa09054599e4f395c756631`. This is development-runtime evidence, not the final signed archive checksum.

Remaining gates include Polish native runs, other mode/personality and useful-action/lifecycle coverage, applicable offline restoration/composition, and final signed artifact installation. Measured positive Extreme startup adds roughly20-22seconds for framework ambiguity scans; there is no per-frame scan/census.

Recruitment accounting remains a separate investigation coordinated with AIC Tactics [PR12](https://github.com/UnofficialCrusaderPatch/extension-aic-tactics/pull/12), [PR16](https://github.com/UnofficialCrusaderPatch/extension-aic-tactics/pull/16) and [PR17](https://github.com/UnofficialCrusaderPatch/extension-aic-tactics/pull/17). No shared recruitment code has changed.

Multiplayer testing belongs to players and is outside this worker's acceptance scope. Report the executable/module versions, configuration, expected/actual result and a reproducing save with failures.
