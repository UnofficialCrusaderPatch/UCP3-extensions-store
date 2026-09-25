# Tunnelers and engineers: single-player test setup

**TL;DR:** Improved Tunnelers **1.7.2** corrects terrain cleanup, including tunnels
under buildings and cleanup when a tunneler is destroyed. It replaces the regressed
1.7.1 test build. Options now have short descriptions in all nine UCP UI languages.

The building/repair delay is **on by default at 100 ticks** (2.5 seconds at normal
speed). Its standard UCP slider allows **1–2400 ticks** and can be switched off.
Find it under **Customizations → Balance Changes → Building after a breach**.
The ground-restoration switch is under **Bugfixes** and defaults on.
Stances are in Bugfixes; raids in AI / Improvements; diagnostics in Miscellaneous.

## Install

1. Use a UCP **3.0.7** test installation. Extract the outer download once.
2. Copy all inner ZIPs and adjacent `.zip.sig` files from `modules/` into
   `ucp/modules/`. Keep the inner ZIPs intact.
3. Select **Improved Tunnelers 1.7.2** and its included dependencies, including
   **Map Extensions 1.1.5**. Disable the old duplicate **Unit Behaviour Fixes**.
4. Apply, restart, and start a new single-player match. Use the defaults first.

AI Swapper 1.5.0 and Fixed Engineers 0.1.0 are also included but remain independent.
AI Swapper owns extra starting tunnelers; they are zero unless configured. Fixed
Engineers only fixes siege crew death/fire cleanup and safe dismounting.
All eight unchanged packages are reused from the previous download. No Python
or developer tools are required. SHA256SUMS.txt lists the module archive hashes.

## Short checks for Monsterfisch

- **Ground:** Try short, long and overlapping tunnels on flat and raised ground,
  beside walls and under buildings. Also destroy a tunneler before it finishes.
  Ground should return to its original shape and remain usable for walking/building.
  Unrelated walls and buildings must stay intact.
- **Settings:** Check the 100-tick building delay, then try 2400 and OFF. Switch
  ground restoration off for comparison with the original cleanup. Apply/restart
  between setups. Check translated labels and that your settings are retained.
- **Save and editor:** Save while digging and during collapse; reload and compare.
  Rename a copy to `.map`, open/edit/save/play it. Repeat without Improved Tunnelers,
  then without Map Extensions too. No stuck raised ground should remain. Old
  pending extra effects should not carry into the new scenario.
- **Orders and smoothness:** Check movement, digging, stances and configured AI
  raids. Try several long tunnels in a busy castle and watch for pauses at completion.
- **Replay, if available:** Record/replay with identical packages and settings.
  Actions and damage should match. A replay tool is not included.

Please test normal Crusader and Extreme. Report **passed / failed / could not test**,
the game version/language, and a save or short clip for a problem. Multiplayer
testing is player-owned.

Optional companion checks: configure starting tunnelers in AI Swapper and verify
they appear once in the ordinary starting group; dismount injured engineers and
check their health, then destroy a crewed siege engine and check crew cleanup.

## Status and limits

This is a **signed test candidate**, not a completed store release. Sixteen focused
module tests pass. Actual native brush/coordinate-helper/cleanup instructions and
stock section dispatch are covered across six fixture files (two SHC/Extreme code
layouts); downstream path/damage functions are stubs. This does not establish
in-game appearance, editor/replay results, installed GUI layout or performance.
The unchanged Map Extensions owner previously passed 32 tests.

Exact saved-match/replay continuation requires matching modules/settings. Converted
maps start fresh. No old-save migration is promised. Stock file-size limits and
other modules' requirements still apply. Existing damage-queue saturation and live
patch-unload limitations remain; restart when changing setups. Human translation
review, game acceptance and upstream license/maintainer review remain open.
Engineer recruitment accounting and new AI siege tactics are outside these packages.

[Improved Tunnelers PR1](https://github.com/Monsterfisch/ImprovedTunnelers/pull/1) ·
[Store PR42, branch 3.0.7](https://github.com/UnofficialCrusaderPatch/UCP3-extensions-store/pull/42) ·
[Terrain audit](https://github.com/Krarilotus/ImprovedTunnelers/blob/fix/ucp-packaging-localization/UCP-TERRAIN-RESET.md) ·
[Map Extensions prerequisite](https://github.com/Krarilotus/ucp-extension-map-extensions/pull/3)
