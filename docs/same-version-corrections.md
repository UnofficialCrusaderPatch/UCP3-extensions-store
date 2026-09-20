# Same-version corrections

Existing recipes reuse published binaries by extension name and version. An
explicitly authorized replacement can opt into source-aware reuse by setting
`contents.source.rebuild-on-source-change: true` and updating the pinned
`github-sha`. Keep the extension definition version unchanged.

For an opted-in entry, reuse additionally requires matching source method,
repository, commit, subdirectory and extension type override. The branch/tag
label does not replace commit identity. Missing source receipts or commit pins
cannot satisfy this check. Other recipes retain their existing behavior.

The normal Store build then packages and signs the changed extension and the
normal release workflow replaces its ZIP and Store metadata. Later builds can
reuse that corrected binary. Preserve a receipt of the superseded package and
verify the released ZIP, hash, signature and source pin after publication.

The current launcher identifies installed extensions by name and version.
Existing installations therefore need an explicit reinstall to receive a
same-version correction; this mechanism does not provide an automatic update.
