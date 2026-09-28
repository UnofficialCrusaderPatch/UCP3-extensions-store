# Worker Delivery Fix 0.1.0 — single-player test package

Copy `worker-delivery-fix-0.1.0.zip` and its `.zip.sig` file into `ucp/modules/` without extracting the module ZIP. Use UCP 3.0.7, select **Worker Delivery Fix** in Content, leave **Bugfixes → Granary and armory delivery** ON, then restart the game. The fix is ON by default when the module is selected. No other optional module is required.

- [ ] Check ordinary deliveries to a granary and armory.
- [ ] Block the route from the keep while leaving the worker's route open; confirm deliveries continue.
- [ ] Check an AI keeps a granary and armory with valid entrances when the keep route is blocked.
- [ ] Block the worker's route too; confirm goods cannot cross it and workers do not vanish unexpectedly.
- [ ] Turn the switch OFF, restart, and compare with the original behavior.
- [ ] Repeat in normal Crusader and Extreme. Save/reload, then rename a save to `.map` and open it in the game editor.

This is a signed **test candidate**. Static checks passed, but the listed in-game and editor cases remain to be verified. Multiplayer testing belongs to players.
