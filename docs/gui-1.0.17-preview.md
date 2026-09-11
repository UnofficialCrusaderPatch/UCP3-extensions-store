# GUI 1.0.17 package and Store preview

This draft coordinates searchable topics, clearer preset names and related extension families with GUI 1.0.17. It keeps the existing extension/configuration system and includes the reviewed pending Store additions. It is not a released catalog.

## What users will see

- Search extensions using translated topics as well as names and descriptions.
- Browse related options together and expand a family to select a different member.
- Recognize presets through names such as “Apply Vanilla Fixed Castles”.
- Get the pending replay, audio, map and projectile additions when their own review and testing requirements are complete.

## Source and compatibility

Base: `cfbca47b6c39b33f84baf5d88406b26f6eb0c342` (3.0.7). The recipe retains 74 exact historical/pending source entries and adds 71 patch versions from 66 draft package PRs. Historical archives are not replaced. Exact dependency pins, including Ascension AI Balance 1.1.3, remain available.

The recipe uses temporary preview branches/forks for the new patch commits so the existing clone-by-branch builder can fetch them. These are review pins, not a permanent repository migration. Before production merge, finish the source reviews and replace each temporary source with the intended upstream repository, stable branch/tag and verified merged SHA. The separate pending Store PRs retain their original upstream promotion rules. No Store workflow, signing step, Python setup or runtime build system is changed.

The two pre-existing recipe hints `Xanders-Plug-and-Play` and `ucp-autoclick` are corrected to the names already in their exact source definitions (`Xanders-Crusader-Mod` and `autoclicker`). This changes neither package identity nor historical payload. Kirito’s new package proposal separately retains its published `Kirito-Kun` identity after an unversioned source-main rename.

## Pending Store work and release requirements

| Store PR | Included head | Review requirement retained |
| --- | --- | --- | --- |
| [#28](https://github.com/UnofficialCrusaderPatch/UCP3-extensions-store/pull/28) | `9b6ae6246ed00a53ca3e1711449a65137dabd1e4` | Recorder/UI/Legacy upstream reviews and merges. Historical Recorder 0.49.4 is retained; proposed 0.50.2 stacks metadata on PR46 0.50.1. New seeking/snapshot work is experimental and still needs its own live acceptance. Do not certify it using earlier replay checks. |
| [#29](https://github.com/UnofficialCrusaderPatch/UCP3-extensions-store/pull/29) | `23bfb464349a5db102487e9b14deea776b88c713` | Audio Fixes remains preview: owner requested review before publication; untested platforms and multiplayer claims remain excluded. |
| [#30](https://github.com/UnofficialCrusaderPatch/UCP3-extensions-store/pull/30) | `25005bdb5f141a5fe754a1dcc8639a7bdf559651` | Map PNG remains preview: object cleanup live acceptance, license/artwork review and Extreme UI support limits remain visible. |
| [#31](https://github.com/UnofficialCrusaderPatch/UCP3-extensions-store/pull/31) | `3338d64a5a5e5cde607a9fcce4c8e9fd9ed4c137` | Custom Projectiles remains preview: physical multiplayer/replay acceptance remains open. |
| [#32](https://github.com/UnofficialCrusaderPatch/UCP3-extensions-store/pull/32) | `3d3be2852c3deb7c50dd2cb49ceef0440bb32574` | Map Layer Fixes remains preview: original-save live acceptance remains open; no increased region-limit claim. |

Module metadata for UI, Legacy and Recorder is stacked on their existing feature/fix branches. Starting Resources, Running Units and Ox Tethers metadata is stacked on their existing compact-settings PRs, preserving those improvements and their authors. These stacked PRs must be incorporated/rebased into the corresponding upstream review before production promotion. Legacy’s separate speed-step proposal, Steam UI development, AIC loader changes and other unrelated open source PRs are not silently merged.

## Package PRs

| Package | Patch version | Family / root | Draft review |
| --- | --- | --- | --- |
| AI-Tournament-Maps | 1.0.0 → 1.0.1 | Independent | [PR](https://github.com/Krarilotus/extension-AI-Tournament-Maps/pull/1) |
| Aggressive-AI-Behaviour | 1.4.0 → 1.4.1 | aggressive-ai-behaviour | [PR](https://github.com/Krarilotus/extension-Aggressive-AI-Behaviour/pull/1) |
| Aggressive-AI-Behaviour-Applied | 1.4.0 → 1.4.1 | aggressive-ai-behaviour (root) | [PR](https://github.com/Krarilotus/extension-Aggressive-AI-Behaviour-Applied/pull/1) |
| ApeX-AI-Behaviour | 1.4.0 → 1.4.1 | apex-ai-behaviour | [PR](https://github.com/Xander10alpha/extension-ApeX-AI-Behaviour/pull/1) |
| ApeX-AI-Behaviour-Applied | 1.4.0 → 1.4.1 | apex-ai-behaviour (root) | [PR](https://github.com/Xander10alpha/extension-ApeX-AI-Behaviour-Applied/pull/1) |
| Vanilla-Interpretation-Castles | 1.0.2 → 1.0.3 | vanilla-interpretation-castles | [PR](https://github.com/Krarilotus/extension-Vanilla-Interpretation-Castles/pull/2) |
| Vanilla-Interpretation-Castles-Applied | 1.0.2 → 1.0.3 | vanilla-interpretation-castles (root) | [PR](https://github.com/Krarilotus/extension-Vanilla-Interpretation-Castles-Applied/pull/1) |
| Vanilla-Retraced-Unlocked | 1.0.2 → 1.0.3 | Independent | [PR](https://github.com/Krarilotus/Vanilla-Retraced/pull/1) |
| ucp2-ai-files | 2.15.1 → 2.15.2 | ucp2-legacy | [PR](https://github.com/UnofficialCrusaderPatch/extension-ucp2-ai-files/pull/1) |
| ucp2-aic-patch | 2.15.1 → 2.15.2 | ucp2-legacy | [PR](https://github.com/UnofficialCrusaderPatch/extension-ucp2-aic-patch/pull/1) |
| ucp2-evrey-aiv | 2.15.1 → 2.15.2 | ucp2-legacy | [PR](https://github.com/UnofficialCrusaderPatch/extension-ucp2-evrey-aiv/pull/1) |
| ucp2-legacy-defaults | 2.15.1 → 2.15.2 | ucp2-legacy (root) | [PR](https://github.com/UnofficialCrusaderPatch/extension-ucp2-legacy-defaults/pull/3) |
| ucp2-tatha-aiv | 2.15.1 → 2.15.2 | ucp2-legacy | [PR](https://github.com/UnofficialCrusaderPatch/extension-ucp2-tatha-aiv/pull/1) |
| ucp2-vanilla-fixed-aiv | 2.15.1 → 2.15.2 | ucp2-legacy | [PR](https://github.com/UnofficialCrusaderPatch/extension-ucp2-vanilla-fixed-aiv/pull/1) |
| Legends-Of-The-Orient | 3.1.7 → 3.1.8 | legends-of-the-orient (root) | [PR](https://github.com/CrusaderPilaw/extension-Legends-of-the-Orient/pull/2) |
| Legends-Of-The-Orient-AI | 3.1.7 → 3.1.8 | legends-of-the-orient | [PR](https://github.com/CrusaderPilaw/extension-Legends-of-the-Orient-AI/pull/2) |
| Schlossgespenst-KI | 1.0.3 → 1.0.4 | schlossgespenst-ai (root) | [PR](https://github.com/Schlossgespensty/Schlossgespenst-KI/pull/1) |
| Schlossgespenst-KI-files | 1.0.7 → 1.0.8 | schlossgespenst-ai | [PR](https://github.com/Schlossgespensty/Schlossgespenst-KI-files/pull/1) |
| ConqueringChristmas | 1.0.1 → 1.0.2 | Independent | [PR](https://github.com/Monsterfisch/ConqueringChristmas_-Stronghold1_textures-with-snow-/pull/1) |
| ConqueringEurope | 1.0.0 → 1.0.1 | Independent | [PR](https://github.com/Monsterfisch/ConqueringEurope_-Stronghold1_textures-/pull/2) |
| ConqueringArabia | 1.0.3 → 1.0.4 | Independent | [PR](https://github.com/Monsterfisch/ConqueringArabia_-fixed_updated_StrongholdCrusader_texture-/pull/1) |
| Kirito-Kun | 1.0.0 → 1.0.1 | Independent | [PR](https://github.com/Xander10alpha/extension-Kirito-Kun-AI/pull/1) |
| Ascension-AI | 1.0.0 → 1.0.1 | ascension | [PR](https://github.com/Krarilotus/Ascension/pull/34) |
| Ascension-AI-Balance | 1.2.0 → 1.2.1 | ascension | [PR](https://github.com/Krarilotus/Ascension/pull/34) |
| Ascension-Balance | 1.1.4 → 1.1.5 | ascension | [PR](https://github.com/Krarilotus/Ascension/pull/34) |
| Ascension-Maps | 1.0.2 → 1.0.3 | ascension | [PR](https://github.com/Krarilotus/Ascension/pull/34) |
| Ascension-Multiplayer | 1.0.11 → 1.0.12 | ascension (root) | [PR](https://github.com/Krarilotus/Ascension/pull/34) |
| Community-Paket | 1.1.0 → 1.1.1 | community-paket (root) | [PR](https://github.com/Nevikov/Community-Paket-UCP3/pull/3) |
| Community-Paket-Files | 1.1.0 → 1.1.1 | community-paket | [PR](https://github.com/Nevikov/Community-Paket-UCP3/pull/3) |
| Die-neuen-Herrscher | 1.0.0 → 1.0.1 | die-neuen-herrscher (root) | [PR](https://github.com/Hacksuelze/Die-neuen-Herrscher/pull/3) |
| Die-neuen-Herrscher-KI-Files | 1.0.0 → 1.0.1 | die-neuen-herrscher | [PR](https://github.com/Hacksuelze/Die-neuen-Herrscher-KI/pull/2) |
| Kommander-AI | 1.0.0 → 1.0.1 | Independent | [PR](https://github.com/Xander10alpha/extension-Kommander-AI/pull/1) |
| Xanders-UCP-AI-Default | 1.0.0 → 1.0.1 | Independent | [PR](https://github.com/Xander10alpha/extension-Xanders-UCP-AI-Default/pull/1) |
| Xanders-Crusader-Mod | 1.0.0 → 1.0.1 | Independent | [PR](https://github.com/Xander10alpha/extension-Xanders-Crusader-Mod/pull/1) |
| NewBalance-Nevikov | 1.0.2 → 1.0.3 | Independent | [PR](https://github.com/Nevikov/New-Balance/pull/4) |
| Ascension-AI-Tournament | 3.0.8 → 3.0.9 | Independent | [PR](https://github.com/Krarilotus/Ascension-AI-Tournament/pull/1) |
| Schlossgespenst-Ascension-PvE-Pressure-AI | 1.0.1 → 1.0.2 | Independent | [PR](https://github.com/Schlossgespensty/Schlossgespenst-Ascension-PvE-Pressure-AI/pull/1) |
| Mod-KI-Team-Liga | 2.0.2 → 2.0.3 | Independent | [PR](https://github.com/Nevikov/Mod-KI-Team-Liga/pull/2) |
| Seraphine-and-Verehrer | 1.0.2 → 1.0.3 | Independent | [PR](https://github.com/Krarilotus/Seraphine/pull/2) |
| aiv-troops-behaviour | 0.2.3 → 0.2.4 | Independent | [PR](https://github.com/Krarilotus/ucp3-fixes/pull/1) |
| hopfarm-limit-fix | 0.1.2 → 0.1.3 | Independent | [PR](https://github.com/DanielFleger/ucp3-fixes/pull/4) |
| autoclicker | 1.0.1 → 1.0.2 | Independent | [PR](https://github.com/americanpotato/ucp-autoclick/pull/1) |
| aiSwapper | 1.4.0 → 1.4.1 | Independent | [PR](https://github.com/UnofficialCrusaderPatch/extension-aiSwapper/pull/18) |
| aicloader | 1.1.2 → 1.1.3 | Independent | [PR](https://github.com/UnofficialCrusaderPatch/extension-aicloader/pull/16) |
| aivloader | 1.0.0 → 1.0.1 | Independent | [PR](https://github.com/UnofficialCrusaderPatch/extension-aivloader/pull/1) |
| files | 1.3.0 → 1.3.1 | Independent | [PR](https://github.com/UnofficialCrusaderPatch/extension-files/pull/9) |
| gmResourceModifier | 0.2.0 → 0.2.1 | Independent | [PR](https://github.com/UnofficialCrusaderPatch/ucp_gmResourceModifier/pull/5) |
| graphicsApiReplacer | 1.3.0 → 1.3.1 | Independent | [PR](https://github.com/UnofficialCrusaderPatch/ucp_graphicsApiReplacer/pull/23) |
| maploader | 1.1.0 → 1.1.1 | Independent | [PR](https://github.com/UnofficialCrusaderPatch/extension-maploader/pull/4) |
| textResourceModifier | 0.3.0 → 0.3.1 | Independent | [PR](https://github.com/UnofficialCrusaderPatch/ucp_textResourceModifier/pull/7) |
| winProcHandler | 1.0.0 → 1.0.1 | Independent | [PR](https://github.com/UnofficialCrusaderPatch/ucp_winProcHandler/pull/4) |
| rebalancer | 1.1.4 → 1.1.5 | Independent | [PR](https://github.com/CIO61/rebalancer/pull/14) |
| citizens | 1.0.1 → 1.0.2 | Independent | [PR](https://github.com/gynt/ucp-extension-citizens/pull/2) |
| custom-skirmish-trails | 1.2.6 → 1.2.7 | Independent | [PR](https://github.com/gynt/ucp-extension-custom-skirmish-trails/pull/9) |
| workers | 0.0.1 → 0.0.2 | Independent | [PR](https://github.com/gynt/ucp-extension-workers/pull/1) |
| map-extensions | 1.0.0 → 1.0.1 | Independent | [PR](https://github.com/gynt/ucp-extension-map-extensions/pull/1) |
| protocol | 1.0.0 → 1.0.1 | Independent | [PR](https://github.com/gynt/ucp-extension-protocol/pull/1) |
| cffi | 1.0.0 → 1.0.1 | Independent | [PR](https://github.com/gynt/ucp-extension-cffi/pull/1) |
| luajit | 1.0.0 → 1.0.1 | Independent | [PR](https://github.com/gynt/ucp-extension-luajit/pull/6) |
| automarket | 1.1.0 → 1.1.1 | Independent | [PR](https://github.com/Krarilotus/ucp-extension-automarket/pull/1) |
| steam-multiplayer | 1.2.3 → 1.2.4 | Independent | [PR](https://github.com/gynt/ucp-extension-steam-multiplayer/pull/5) |
| recorder | 0.50.1 → 0.50.2 | Independent | [PR](https://github.com/Krarilotus/ucp_recorder/pull/1) |
| ui | 1.0.1 → 1.0.2 | Independent | [PR](https://github.com/Krarilotus/ucp-extension-ui/pull/1) |
| ucp2-legacy | 2.15.2 → 2.15.3 | ucp2-legacy | [PR](https://github.com/Krarilotus/extension-ucp2-legacy/pull/1) |
| ai-ox-tethers | 1.0.4 → 1.0.5 | Independent | [PR](https://github.com/Krarilotus/ucp-extension-ai-ox-tethers/pull/2) |
| running-units | 1.0.3 → 1.0.4 | Independent | [PR](https://github.com/Krarilotus/ucp-extension-running-units/pull/1) |
| startResources | 1.0.2 → 1.0.3 | Independent | [PR](https://github.com/Krarilotus/ucp-extension-startResources/pull/2) |
| custom-projectiles | 1.8.0 → 1.8.1 | Independent | [PR](https://github.com/Krarilotus/extension-projectileModifier/pull/1) |
| map-png | 0.1.0 → 0.1.1 | Independent | [PR](https://github.com/Krarilotus/ucp-extension-map-png/pull/1) |
| audio-fixes | 0.1.0 → 0.1.1 | Independent | [PR](https://github.com/Krarilotus/extension-audio-fixes/pull/6) |
| map-layer-fixes | 0.1.3 → 0.1.4 | Independent | [PR](https://github.com/Krarilotus/extension-map-layer-fixes/pull/2) |

## Validation and promotion

- Exact source definitions were fetched at all 74 original/pending pins; names and versions are checked against source, not branch labels.
- The GUI’s actual configuration parser and search implementation validate all 71 new definitions, their configuration-demand facts and translated tags in nine languages. All nine family roots are unique identities. Dependencies are unchanged.
- Each metadata commit has its reviewed base as parent and changes only its prepared manifest/changelog, plus the explicit Kirito identity and AI Tournament Maps version-path corrections.
- The package PRs and source pins are independently rechecked before review handoff. Full package compilation/signing and runtime acceptance are not implied by metadata validation.
- Review and merge source PRs first; replace temporary fork/branch pins with exact upstream merged commits; run the normal Store build/signing checks; publish only after the separate module acceptance requirements and GUI release preparation are satisfied.

No game testing, signed Store release or upstream-main merge was performed for this coordination PR.
