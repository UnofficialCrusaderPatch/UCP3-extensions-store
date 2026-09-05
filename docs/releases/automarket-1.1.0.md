# Automarket 1.1.0 and Ascension-Multiplayer 1.0.10

Automarket 1.1.0 fixes oversized multiplayer settings messages and trading fee
accounting, and synchronizes each player's committed fee across peers.
Ascension-Multiplayer 1.0.10 requires this release or a compatible newer 1.x
version. Both packages are updated together in the 3.0.7 store recipe.

## Pinned sources

- Automarket: [PR #2](https://github.com/gynt/ucp-extension-automarket/pull/2),
  commit `858890f558fd042215913e862745d98ed13d8834` in
  `Krarilotus/ucp-extension-automarket`, branch `fix/multiplayer-sync-and-fees`.
  The store deliberately builds the PR commit before its upstream merge.
- Ascension-Multiplayer: [PR #31](https://github.com/Krarilotus/Ascension/pull/31),
  merge commit `18e136e0a395ff319edea2895b31e2bc6a25f519` in
  `Krarilotus/Ascension`, branch `ucp3-ascension`.

## Upgrade and live test

All participants must update together and use the same Automarket version.
After loading a save made with Automarket 1.0.0, each player must open
Automarket and use **Save & Close** before automated trading resumes. New
Automarket saves use format 2 and are not backward compatible with 1.0.0.

The preset still suggests a 5% market fee. Fees are committed per player;
they are not overridden by the host.

For live multiplayer testing, repeatedly save settings while issuing game
commands, run automated trades for several weeks, check failed/full-storage
purchases and exact-reserve purchases, and save/reload the match. Keep logs
from every peer and the save if a crash or desync occurs. Automated LuaJIT
tests pass; live multiplayer validation is still pending.

## Rollout order

1. Push the versioned Automarket PR commit.
2. Merge the Ascension-Multiplayer dependency update.
3. Merge both recipe changes together into `3.0.7` and let the store workflow
   build, sign, and publish the packages.
4. Verify the published store versions, dependency, and package contents before
   asking players to refresh their extensions.
