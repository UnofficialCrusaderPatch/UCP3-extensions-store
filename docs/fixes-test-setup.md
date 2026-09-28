# Fixes test setup for UCP 3.0.7

Extract the outer download once. Copy the four module ZIPs and their matching
`.zip.sig` files into `ucp/modules/` without extracting the module ZIPs. In
UCP 3.0.7 Content, select **UCP3 Fixes** to activate all three fixes together.
The upcoming family-enabled launcher groups them beneath that bundle; the
current launcher lists them separately. Each fix can also be selected alone.
Their switches are under **Bugfixes** and are ON by default. Restart the game
after changing a switch. No other optional module is needed.

- [ ] **Deliveries:** Block the keep route but leave a worker route to a granary or armory open. Workers should still deliver, and the AI should keep the store.
- [ ] **Gatehouses:** Kill the last defender while a living attacker remains. A visible corpse should not keep control. Repeat with a dead attacker and living defender.
- [ ] **Hunters:** Place a deer beside a hunter's hut. Then block a shot with terrain or a wall; the hunter should move closer and try again.
- [ ] Turn each switch OFF and restart to compare with the original behavior.
- [ ] Repeat representative cases in normal Crusader and Extreme, including save/load and replay. Check that a renamed save opens as a `.map` in the editor.

These are signed **test candidates**. Native bindings, isolated branches,
packaging and localization have been checked; the listed gameplay and editor
cases remain pending. Multiplayer testing belongs to players.
