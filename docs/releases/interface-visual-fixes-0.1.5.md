# Interface and Visual Fixes 0.1.5

Improve compatibility checks and crash diagnostics, and correct lower tower doors.

Startup diagnostics are automatic and add no per-frame logging. Save the UCP logs before restarting after a crash. [Crash reporting and optional Windows dump capture](https://github.com/Krarilotus/extension-interface-visual-fixes/blob/140758314f1acc7cfbf93925bc9d5ab8a4408a28/docs/crash-reporting.md).

The reported intermittent blitter crash remains under investigation; this update does not claim it is fixed.

Seven fixes for SHC/SHCE 1.41 and UCP 3.0.7, enabled by default. Each can be switched off separately. Apply your settings and restart the game.

- Keep custom map descriptions visible in the lobby.
- Clear the building preview after successfully placing a unique building.
- Update building previews while scrolling the camera.
- Show distinct standing-dead trees before fallen logs.
- Align tower doors with connections and extend wall masonry beneath cliff-edge towers.
- Show the existing Load button in the single-player lobby.
- Improve cliff continuity after rotation and on diagonal steps.

Front-facing steps use consecutive strips; receding steps use stable variation where overlap prevents continuity.

Tower doors choose the highest eligible connection; nearest centre breaks ties. Outer doors move half a tile inward. AI stair6 alone allows a ground door; raised stairs do not count.

Tower masonry with doors at the connecting wall heights.

![Tower masonry with doors at the connecting wall heights.](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/b666f94ac104c46193af8bb12c8c7c8364fb0fa0/docs/store/tower-foundation.png)

Connected cliff textures after rotation.

![Connected cliff textures after rotation.](https://raw.githubusercontent.com/Krarilotus/extension-interface-visual-fixes/b666f94ac104c46193af8bb12c8c7c8364fb0fa0/docs/store/cliff-textures.png)
