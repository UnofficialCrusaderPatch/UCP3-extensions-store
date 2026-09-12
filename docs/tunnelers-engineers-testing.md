# Tunnelers and engineers: single-player testing

## TL;DR

This release is **not ready to install**. AI tunneler starting troops are being
investigated in AI Swapper. Existing Engineer starting counts worked in the two
local baseline builds; no engineer/tunneler recruitment-accounting correction
has been established or implemented yet.

There is **no feature ZIP or download link yet**. This document reserves the
testing and delivery notes for the `3.0.7` store PR. It does not add a module to
the store or claim that an existing AI Swapper archive contains these changes.

Implementation tracking: [AI Swapper #19](https://github.com/UnofficialCrusaderPatch/extension-aiSwapper/issues/19).
Recruitment ownership overlaps AIC Tactics
[#12](https://github.com/UnofficialCrusaderPatch/extension-aic-tactics/pull/12),
[#16](https://github.com/UnofficialCrusaderPatch/extension-aic-tactics/pull/16) and
[#17](https://github.com/UnofficialCrusaderPatch/extension-aic-tactics/pull/17).

## Before providing a download

- Complete native initialization, acquisition, placement and role/group
  registration through AI Swapper and the verified native services. Preserve
  the packed 20-slot starting-troop table and use verified UCP runtime discovery.
- Reproduce the suspected recruitment defect, coordinate shared sites with AIC
  Tactics, and either verify the responsible correction or record a supported
  no-change result. Do not advertise an unproved fix.
- Complete single-player SHC and Extreme acceptance on the applicable supported
  variants, including zero/positive/invalid counts, all three starting modes,
  ownership, useful orders, AI behavior, admission limits, save/load/restart,
  applicable offline restoration and performance.
- Verify every supported locale and the installed Customizations controls.
  Verified simple fixes default ON and retain a working OFF control. Additional
  starting troop counts default to zero; existing profiles keep their choices.
- Build using the existing module packaging/signing workflow, verify installation
  from the exact ZIP, and pin the tested source revision and matching module
  version in the store recipe. Preserve the established dependency and trust
  requirements. Do not publish a source-checkout ZIP as an installable module.
- Add the actual download URL, SHA-256, module/dependency versions, tested game
  builds, control names and validation evidence below. Complete CI and review
  before marking the PR ready for release.

## Short test guide to finish with the verified build

These are the required test cases, not instructions for a currently available
feature. Replace the pending installation details with the exact tested workflow
before offering the ZIP to players.

1. Install the versioned module ZIP in the test game's `ucp/modules` directory
   using the verified UCP 3.0.7 workflow and its required dependencies. The final
   instructions must name the archive, required versions and activation steps.
2. In Customizations, configure a positive tunneler starting count for an AI
   through AI Swapper. The final instructions must name the actual localized
   control and category. Also check zero/omitted counts preserve existing starts.
3. Start a **single-player** skirmish with that AI. Check the requested count
   using the documented mode/advantage settings, correct ownership and placement,
   valid selection/orders and eventual AI use. Repeat with two slots using the
   same personality to catch player/character indexing errors.
4. Save and reload, then restart the match. Reloading must not add another batch;
   restarting must initialize the configured count exactly once. Repeat in normal
   SHC and Extreme using the documented supported builds.
5. For any verified accounting correction included in the release, compare its
   default ON behavior with OFF using the supplied quota fixture. Recruitment
   must stop at the proper quota and replace a legitimate loss without repeated
   spending on already-counted working units. Save the configuration and confirm
   that the selected ON/OFF value persists.

Report the game/module versions, configuration, expected/actual result and a
reproducing save with any failure. Multiplayer testing belongs to players and
is outside this worker's acceptance scope; no multiplayer validation is claimed.

## Evidence available so far

The baseline used existing signed UCP 3.0.7 / AI Swapper 1.1.0, without the new
feature: two Wolves, Normal Game and centered advantage. Local SHC 1.41 on Green
Haven and Extreme 1.41 on MP-Downhill Scrum each produced three archers and three
engineers per Wolf, while the requested Tunneler entry was ignored. The Extreme
map's name does not indicate a multiplayer test; both tests were single-player.

These observations reproduce the missing starting-tunneler capability. They do
not validate a feature build, recruitment correction, supported-variant matrix,
installed localization or final artifact. Release acceptance remains open.
