# UCP3 Fixes 0.1.3 test setup

TL;DR: fixes worker deliveries, hunters, gatehouses, siege crews and AI hop-farm counting.

Extract the outer download once. Copy the seven module ZIPs and matching `.zip.sig`
files from `modules/` into `ucp/modules/`. Do not extract the inner ZIPs. Select
**UCP3 Fixes** in Content. Each fix can also be selected alone. Restart after
changing a setting. Disable the older Unit Behaviour Fixes preview when using
Fixed Engineers; it patches the same crew/command behavior.

Simple fixes are ON by default under **Bugfixes**; hop-farm counting is under
**AI > Fixes**. Gatehouse stairs are optional, OFF by default under **Balance Changes**.
The bundle adds no duplicate settings. Its contents are signed test candidates,
not an accepted Store release. The Store build is run with publication disabled.

- [ ] Workers deliver to a reachable granary/armory even with the keep route blocked.
- [ ] Fallen troops do not capture or defend gates; own/allied/captured gates remain usable.
- [ ] Gate closing works from each side; unreachable enemies do not close an inner gate.
- [ ] Hunters choose nearby deer and move closer when a shot is blocked.
- [ ] Engineers retain health when leaving equipment; destroyed/burning equipment clears crews correctly.
- [ ] Catapults/trebuchets stop to attack, then aim, reload and fire normally.
- [ ] AI hop farms count toward the existing farm limit without changing that limit.
- [ ] Each switch appears once; OFF choices survive restart and applying the bundle.
- [ ] Repeat in normal Crusader and Extreme with save/load, matching-setup replay and other enabled modules.
- [ ] A save renamed to `.map` remains usable in the editor without these optional modules.
- [ ] Check long/RTL translations and performance in a busy match.

Native gameplay, installed GUI, composition, editor/save/replay, performance and
additional supported executable variants remain pending. Multiplayer testing belongs to players.
Gatehouse Fixes comes from its author's pending integration PR; no native code is copied into Fixes.

Every inner package includes its original author and CREDITS.md. Translated tags
use the launcher discovery system. The fixes are compatible dependencies, not
exclusive family choices. This metadata update does not change gameplay code.
