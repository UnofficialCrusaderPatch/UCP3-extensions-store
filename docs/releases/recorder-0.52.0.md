# Recorder 0.52.0

Replay restore points can now contain every module's saved data. When Map
Extensions provides its save archive (the 1.2 candidate, not yet in the Store),
Recorder stores the same archive a normal save writes, so seeking in a replay
restores Improved Tunnelers, Automarket, UCP2-Legacy and any other registered
module through their own load code.

With the Store's Map Extensions 1.0.0, nothing changes: Recorder keeps its
Automarket and UCP2-Legacy adapter, as in 0.51.1. Without Map Extensions there is
no extension data to keep. Any other Map Extensions 1.x is now accepted at
startup; if it lacks the archive, Recorder skips restore points and seeking
replays from the starting save.

Dependencies are unchanged: UCP 3.0.7 or newer and UI 1.0.1 or a compatible 1.x
release. Map Extensions, Automarket, UCP2-Legacy and other modules stay
optional. When UCP2-Legacy is active, Recorder still needs 2.15.2 or newer (the
Store's version, which Vanilla Retraced accepts); 2.15.1 keeps AI state outside
saved games, so Recorder stays off for that launch with a message and the game
continues.

Replay and restore point formats are unchanged. A replay keeps the exact versions
it was recorded with: keep Recorder 0.51.1 installed to play 0.51.1 replays (the
launcher's Store update keeps it). Loading a multiplayer save made with a
different set of modules, versions or settings is not advised.

Validation: 506 Recorder tests (one skipped) on Lua 5.4 and LuaJIT, including
the module-setup matrix and mutation-checked fallbacks; Recorder's checks against
the original Crusader and Extreme 1.41 executables (58 passed); the Store's
`build-store.ps1` run locally with PowerShell 7 and a throwaway signing key: it
built only Recorder 0.52.0 from this source, and the resulting `store.yml` differs
from the published one only in that entry. In-game: IN_GAME_PLACEHOLDER

Source: `Krarilotus/ucp_recorder`, branch `release/recorder-0.52.0`, commit
`8d53b00597a5fb91c8f57ff4df18dc342828fd6d`.
