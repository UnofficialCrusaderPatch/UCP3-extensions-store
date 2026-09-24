# Tunnelers and engineers: single-player test bundle

**TL;DR:** Three independent modules, with their five module dependencies and
UCP signatures. AI Swapper1.5.0 owns starting tunnelers. Improved Tunnelers1.6.6
owns tunneling, stance response and raid behaviour. Fixed Engineers0.1.0 contains
only siege crew death/fire cleanup and safe dismounting. The old duplicate
Unit Behaviour Fixes module is no longer in this bundle.

This is a **test candidate**, not a complete release. Engineer recruitment
accounting and the newly requested AI siege placement, coordinated harassment,
expanded force limits and resource-payment/reservation policies are not included.
All nine GUI option/description catalogs are present; human translation review,
technical diagnostic localization and installed-game/GUI acceptance remain open.

## Install

1. Use a separate UCP3.0.7 test installation and preserve your configuration.
2. Extract the outer download once. Copy every ZIP and adjacent `.zip.sig` from
   `modules/` into the game's `ucp/modules/`. Keep the inner ZIPs intact; these
   are signed packages and need no security bypass.
3. Disable **Unit Behaviour Fixes** if selected. Select **Improved Tunnelers**
   and/or **Fixed Engineers**. Select **AI Swapper1.5.0** only if you want its
   starting-troop configuration. Let the GUI enable each module's dependencies.
   Improved Tunnelers 1.7.0 requires the included Map Extensions 1.1.5.
   Apply and restart. Keep old recording setups backed up; recordings need their
   exact original package files and settings.

Fixed Engineers' single **Siege crew cleanup** switch defaults ON under
**Customizations → Bugfixes**. Improved Tunnelers' switches are in its existing
localized **Improved Tunnelers** category, default ON except diagnostics OFF.
The two previously inconsistent UI defaults now match the original module's
runtime values:120 seconds of building restriction and60 nearby-building damage.
Explicit saved values remain effective. If the old crew switch was OFF, keep
the new Fixed Engineers switch OFF when migrating: module renames do not migrate
another module's saved configuration automatically.

## Short tests

- **Starting troops:** In AI Swapper, select an AI slot, enable its Starting
  troops component, enter3 for Normal starting tunnelers, Save/Close and Apply.
  Start a new Normal single-player match with centered advantage. That AI should
  receive3 additional tunnelers in its ordinary keep-defense group. Save/load
  must not add another batch. Crusader/Deathmatch have independent counts;0
  suppresses them and an empty field inherits the selected AI pack.
- **Tunnelers:** Compare idle response to nearby enemies with Stances ON/OFF.
  With the attack-button option OFF, check that the original dig button remains;
  restart with it ON and check both attack-here and dig buttons.
  Test a digging order, and an AI with a Tunneler's Guild plus Tunneler in its
  raid settings. Improved Tunnelers already supplies that raid implementation;
  this contribution does not add a second raid controller or a new AIV row.
- **Engineers:** Dismount injured engineers and check surviving health. Destroy
  a crewed engine and check that living crew do not remain hidden. Restart with
  Siege crew cleanup OFF for the native comparison.
- **Game text:** With building denial/message enabled, breach a fortification
  and attempt to rebuild there. The refusal should follow game language, which
  can differ from GUI language. Unrecognized languages keep the native message.
- **Save/replay:** Save during a collapse, continue, reload and compare with
  uninterrupted play; repeat after restarting the game process. Record/replay
  with identical packages/settings. Collapse speed now bounds both new tunnel
  tiles and damage calls per tick; dense collapses may take longer, independently
  of CPU speed and diagnostics.
- **Map editor:** Copy a save into Maps, rename `.sav` to `.map`, open/edit/save
  it in the game editor and start a new match. The native map content remains;
  pending collapse/denial state from the original battle starts fresh. Ordinary
  `.sav` loads retain ongoing work. Older-save migration is out of scope.

AI Swapper starting counts remain zero unless authored/configured. Neither
Improved Tunnelers nor Fixed Engineers is required to spawn starting tunnelers.
Use new games for assignment comparisons.
Avoid the old Unit Behaviour Fixes tunneler patch alongside Improved Tunnelers.

## Evidence and limits

Fixed Engineers preserves the existing crew/unman native payloads.35 repository
tests,66 crew binding/preflight cases across six SHC/Extreme fixtures, and
dismount instruction checks for partial/full crews, reused IDs, bounds, repeat
commands and complete valid unit-pool equality pass. Earlier crew/fire gameplay
evidence belongs to the historical module, not this renamed package.

Improved Tunnelers passes catalog/default/manifest checks and SHC/Extreme Lua
message-lifecycle rejection checks. The latter stubs assembly allocation; no
new native payload, full emulator, text encoding or gameplay pass is implied.
The 1.6.6 Lua audit also corrects the UI OFF path, strengthens keep/tick signatures,
rejects failed native contexts and reuses framework jump encoding. All 15 signatures
match once on each of six fixture files (two distinct native code layouts), and
four focused Lua tests pass. Version 1.7.0 adds deterministic queue scheduling
and saved state through Map Extensions' existing required-state API. Six further
focused tests cover emitted queue/step instructions (native damage/path callees
stubbed), relocated saved state, malformed-state rejection, reset and the actual
owner/stock framework proxy. All ten module tests pass. Map Extensions 1.1.5
passes 32 owner tests, including save-to-map initialization on Lua 5.4/LuaJIT.
AI Swapper is unchanged at26e1b1f;
its earlier starting-defense and single-player evidence remains recorded in PR20.

The saved-state implementation is now present. Installed game/editor/replay
acceptance is still pending; codec tests do not establish those results.
Restoring patches still does not check for later owners, an existing limitation.
The new combined signed bundle has not been run in-game. Full lifecycle, save,
composition, GUI, variant and measured performance acceptance remains incomplete.
AI Swapper positive-count startup previously measured roughly18–22 seconds of
additional discovery time; no per-frame scan is added. Multiplayer testing is
player-owned. Report exact versions/configuration and a reproducing save.

Sources: [AI Swapper PR20](https://github.com/UnofficialCrusaderPatch/extension-aiSwapper/pull/20),
[Improved Tunnelers PR1](https://github.com/Monsterfisch/ImprovedTunnelers/pull/1),
[Fixed Engineers PR4](https://github.com/Krarilotus/ucp3-fixes/pull/4).
[Map Extensions PR3](https://github.com/Krarilotus/ucp-extension-map-extensions/pull/3)
is the editable-map prerequisite, stacked on its existing save-owner work.
[Store PR42](https://github.com/UnofficialCrusaderPatch/UCP3-extensions-store/pull/42)
links the versioned signed download. SHA256SUMS.txt identifies this exact build.
Upstream ImprovedTunnelers license selection and maintainer review remain open
before claiming store release readiness.
