# Recorder 0.51.1

Fix the three empty rows in Customisations → General. Recorder now has its own
translated category with automatic recording, a fixed-seed switch and a seed
input. The seed input is disabled when fixed seed is off.

Labels, descriptions, tooltips and diagnostic categories are translated into
English, German, French, Spanish, Hungarian, Turkish, Russian, Chinese and Persian.
The diagnostic build also receives working controls; its extra settings remain
absent from the normal Store package.

This patch preserves the runtime, dependencies and defaults of Store version
0.51.0. It does not change replay behavior or compatibility guarantees.

Validation: release and diagnostic package checks, locale coverage, PowerShell
and Python package parity, and real launcher component checks for all nine
languages (labels, seed enablement, edits and YAML round-trip).

Source: `Krarilotus/ucp_recorder`, tag `v0.51.1`, commit
`8e0437968c4ccfcfb280af1bc9f951085da9af2a`.
