# Tunnelers and engineers: single-player test setup

**TL;DR:** Improved Tunnelers **1.7.3** fixes the game closing when a save was loaded
after changing a tunneler setting. Saves now load with your current settings.
A collapse that is half done finishes the way it started; changed settings apply
to the next work. Damaged or unsupported save data is still refused, with a short
message in the game's language. Terrain cleanup from 1.7.2 is unchanged.

The building/repair delay is **on by default at 100 ticks** (2.5 seconds at normal
speed). Its standard UCP slider allows **1–2400 ticks** and can be switched off.
Find it under **Customizations → Balance Changes → Building after a breach**.
The ground-restoration switch is under **Bugfixes** and defaults on.
Stances are in Bugfixes; raids in AI / Improvements; diagnostics in Miscellaneous.

## Install

1. Use a UCP **3.0.7** test installation. Extract the outer download once.
2. Copy all inner ZIPs and adjacent `.zip.sig` files from `modules/` into
   `ucp/modules/`. Keep the inner ZIPs intact.
3. Select **Improved Tunnelers 1.7.3** and its included dependencies, including
   **Map Extensions 1.1.6**. Disable the old duplicate **Unit Behaviour Fixes**.
4. Apply, restart, and start a new single-player match. Use the defaults first.

Saves made with 1.7.2 do not load in 1.7.3; start a new match. A 1.7.2 save
renamed to `.map` still opens as a scenario.

AI Swapper 1.5.0 and Fixed Engineers 0.2.0 are also included but remain independent.
AI Swapper owns extra starting tunnelers; they are zero unless configured. Fixed
Engineers fixes crew death/fire cleanup, safe dismounting, and moving catapults
and trebuchets continuing an old path after a direct attack order.
No Python or developer tools are required. SHA256SUMS.txt lists the module
archive hashes.

## Short checks

Mark each **passed / failed / could not test**. Test normal Crusader and Extreme.

- [ ] **Save, change one setting, load.** Save while a tunnel collapses. Close the
  game, change one setting, apply, restart and load. The game must not close.
  Repeat once each for collapse damage, spread radius, repair delay, collapse
  speed, and one on/off switch (for example stances or ground restoration).
- [ ] **Work in progress finishes.** After such a load, the collapse that was
  running continues and finishes. Building stays blocked where the ground was hit,
  until its saved time ends. New tunnels use the new settings.
- [ ] **Several tunnels at once.** Let two or more tunnels collapse together, from
  you and an AI. Save, change the speed, load. All of them should still finish.
- [ ] **Hidden tunnelers.** With *Skip digging tunnelers in selections* on, save while
  a tunneler digs. Turn the setting off, restart, load. Once it stops digging,
  you should be able to select it.
- [ ] **New match after loading.** Load a save, quit to the menu and start a new
  match. Nothing from the old battle should carry over.
- [ ] **Map without the module.** Rename a copy of a save to `.map`, open/edit/save
  it and play it. Repeat without Improved Tunnelers, then without Map Extensions.
  No stuck raised ground should remain.
- [ ] **Old save is refused clearly.** Load a save made with 1.7.2. Expect one
  short message without file paths, then the game closes. It must not keep
  running half loaded.
- [ ] **Replay, if available.** Record/replay with identical packages and settings.
  Actions and damage should match. A replay tool is not included.

Please include the game version/language and a save or short clip for a problem.
Multiplayer testing is player-owned.

Optional companion checks: configure starting tunnelers in AI Swapper and verify
they appear once in the ordinary starting group; dismount injured engineers and
check their health, then destroy a crewed siege engine and check crew cleanup.
Move a crewed catapult and trebuchet, click an enemy unit in another direction,
and check they stop the old path while normal aiming/firing continues. Repeat
with each Fixed Engineers switch OFF after restarting.

## Status and limits

This is a **signed test candidate**, not a completed store release. 24 focused
module tests and 34 Map Extensions tests pass. They run the real Map Extensions load
path and the real collapse/stance code in an emulator, on six SHC/Extreme 1.41
files. Game calls are stubbed. In-game save/load, editor, replay, installed GUI
and performance checks have not been done.

A refused save still closes the game after its message; that is how Map Extensions
handles a world it has already started to load. The message box may show accented
or non-Latin letters incorrectly on some systems. Saved matches need the same module
version; replays also need the same settings. Existing damage-queue saturation and
live patch-unload limitations remain; restart when changing setups. Human
translation review, game acceptance and upstream license/maintainer review remain
open. Engineer recruitment accounting and new AI siege tactics are outside these
packages.

[Improved Tunnelers PR1](https://github.com/Monsterfisch/ImprovedTunnelers/pull/1) ·
[Store PR42, branch 3.0.7](https://github.com/UnofficialCrusaderPatch/UCP3-extensions-store/pull/42) ·
[Save/settings notes](https://github.com/Krarilotus/ImprovedTunnelers/blob/fix/ucp-packaging-localization/UCP-SAVE-SETTINGS.md) ·
[Map Extensions prerequisite](https://github.com/Krarilotus/ucp-extension-map-extensions/pull/3)
