# Run with the Store's existing powershell-yaml dependency installed.
$ErrorActionPreference = 'Stop'
if (-not (Get-Module powershell-yaml)) { Import-Module powershell-yaml }
. "$PSScriptRoot/extension-discovery.ps1"

function Assert-Equal($Actual, $Expected, [string]$Context) {
  if ($Actual -cne $Expected) { throw "$Context`: expected '$Expected', got '$Actual'" }
}

function Test-Package([hashtable]$Files, [scriptblock]$Check) {
  $path = [IO.Path]::GetTempFileName()
  try {
    $stream = [IO.File]::Open($path, [IO.FileMode]::Create)
    $zip = [IO.Compression.ZipArchive]::new($stream, [IO.Compression.ZipArchiveMode]::Create)
    try {
      foreach ($name in $Files.Keys) {
        $entry = $zip.CreateEntry($name)
        $writer = [IO.StreamWriter]::new($entry.Open(), [Text.UTF8Encoding]::new($false))
        try { $writer.Write($Files[$name]) }
        finally { $writer.Dispose() }
      }
    }
    finally { $zip.Dispose(); $stream.Dispose() }
    & $Check (Get-ExtensionDiscoveryMetadata -ArchivePath $path -Languages @('en', 'de', 'fr', 'ru', 'hu', 'tr', 'ch', 'es', 'fa'))
  }
  finally { Remove-Item -LiteralPath $path -Force }
}

Test-Package @{
  'definition.yml' = "name: example`nversion: 1.0.0`ntags: [' Courtyards ', tools, 7]"
  'config.yml' = "config-sparse:`n  modules: {}`n  plugins: {}`n  load-order: [{name: provider, version: 1.0.0}]"
  'options.yml' = ''
  'resources/castle.aiv' = 'fixture'
  'locale/en.yml' = "tags.courtyards: Courtyards`ntags.tools: Tools`ntags.unused: Ignore me"
  'locale/de.yml' = "tags.courtyards: Burghöfe`ntags.tools: Werkzeuge"
  'locale/fr.yml' = "tags.courtyards: 7`ntags.tools: '  '"
  'locale/fa.yml' = ''
} {
  param($metadata)
  Assert-Equal $metadata.Capabilities.files $true 'File provider'
  Assert-Equal $metadata.Capabilities.code $false 'No runtime entry point'
  Assert-Equal $metadata.Capabilities.configuration $false 'Load order alone is not a preset demand'
  Assert-Equal $metadata.Capabilities.options $false 'Empty options file'
  Assert-Equal $metadata.TagLocales.de.courtyards 'Burghöfe' 'Normalized custom tag'
  Assert-Equal $metadata.TagLocales.en.tools 'Tools' 'Known authored tag'
  Assert-Equal $metadata.TagLocales.en.ContainsKey('unused') $false 'Ignore unauthored locale keys'
  Assert-Equal $metadata.TagLocales.ContainsKey('fr') $false 'Ignore malformed labels'
  Assert-Equal $metadata.TagLocales.ContainsKey('fa') $false 'Empty locale'
}

Test-Package @{
  'definition.yml' = "name: applied`nversion: 1.0.0`ntags: [research]"
  'init.lua' = '-- fixture'
  'config.yml' = "config-sparse:`n  modules:`n    target:`n      option:`n        contents:`n          value: false`n          type: boolean`n          suggested: true"
  'options.yml' = "options:`n- header: Test"
  'locale/en.yml' = "tags.research: 'R&D'"
} {
  param($metadata)
  Assert-Equal $metadata.Capabilities.files $false 'Applied package has no copied assets'
  Assert-Equal $metadata.Capabilities.code $true 'Runtime entry point'
  Assert-Equal $metadata.Capabilities.configuration $true 'A false setting still contributes a demand'
  Assert-Equal $metadata.Capabilities.options $true 'Editable options'
  Assert-Equal $metadata.TagLocales.en.research 'R&D' 'Preserve meaningful ampersands'
}

Test-Package @{ 'definition.yml' = "name: minimal`nversion: 1.0.0" } {
  param($metadata)
  Assert-Equal $metadata.Capabilities.configuration $false 'Missing configuration'
  Assert-Equal $metadata.Capabilities.options $false 'Missing options'
  Assert-Equal $metadata.TagLocales.Count 0 'Old package without tags'
}

Test-Package @{
  'definition.yml' = "name: bare`nversion: 1.0.0`nfamily:`n- name: ai`n  root: true"
  'locale/en.yml' = "family.ai: AI Behaviour`nfamily.ai.configuration: Bare`nfamily.unused: Ignored"
  'locale/de.yml' = "family.ai: KI-Verhalten`nfamily.ai.configuration: Ohne Einstellungen"
  'locale/fa.yml' = "family.ai: 7`nfamily.ai.configuration: '  '"
} {
  param($metadata)
  Assert-Equal $metadata.FamilyLocales.en.ai 'AI Behaviour' 'Family display label'
  Assert-Equal $metadata.FamilyLocales.de.'ai.configuration' 'Ohne Einstellungen' 'Configuration display label'
  Assert-Equal $metadata.FamilyLocales.en.ContainsKey('unused') $false 'Ignore undeclared families'
  Assert-Equal $metadata.FamilyLocales.ContainsKey('fa') $false 'Ignore malformed family labels'
}

$root = @{ definition = @{ name = 'bare'; version = '1.0.0'; family = @(@{ name = 'ai'; root = $true }) } }
$member = @{ definition = @{ name = 'applied'; family = @(@{ name = 'ai' }) } }
$rootVersion = @{ definition = @{ name = 'bare'; version = '1.1.0'; family = @(@{ name = 'ai'; root = $true }) } }
Assert-ExtensionFamilyCatalog @($root, $rootVersion, $member)
foreach ($invalid in @(
    @($member),
    @($root),
    @($root, @{ definition = @{ name = 'applied'; family = @(@{ name = 'ai'; root = $true }) } }),
    @($root, @{ definition = @{ name = 'applied'; family = @(@{ name = 'ai'; root = 'yes' }) } }),
    @($root, @{ definition = @{ name = 'applied'; family = @(@{ name = 'ai' }, @{ name = 'ai' }) } }),
    # The launcher ignores these, so the Store must not accept them either:
    @($root, @{ definition = @{ name = 'applied'; family = @{ name = 'ai' } } }),
    @($root, @{ definition = @{ name = 'applied'; family = @(@{ name = 'ai'; root = $null }) } }),
    @($root, $member, @{ definition = @{ name = 'other'; family = @(@{ name = 'AI' }) } })
)) {
  $rejected = $false
  try { Assert-ExtensionFamilyCatalog $invalid }
  catch { $rejected = $true }
  Assert-Equal $rejected $true 'Reject invalid catalog family'
}
# Family IDs that differ only in case are separate families, each checked on its own.
Assert-ExtensionFamilyCatalog @($root, $member,
  @{ definition = @{ name = 'other-bare'; family = @(@{ name = 'AI'; root = $true }) } },
  @{ definition = @{ name = 'other-applied'; family = @(@{ name = 'AI' }) } })

# Cached packages: published facts are kept, missing ones are read from the exact
# published archive after its hash is checked.
function New-TestArchive([hashtable]$Files) {
  $path = [IO.Path]::GetTempFileName()
  $stream = [IO.File]::Open($path, [IO.FileMode]::Create)
  $zip = [IO.Compression.ZipArchive]::new($stream, [IO.Compression.ZipArchiveMode]::Create)
  try {
    foreach ($name in $Files.Keys) {
      $writer = [IO.StreamWriter]::new($zip.CreateEntry($name).Open(), [Text.UTF8Encoding]::new($false))
      try { $writer.Write($Files[$name]) }
      finally { $writer.Dispose() }
    }
  }
  finally { $zip.Dispose(); $stream.Dispose() }
  return $path
}

$archive = New-TestArchive @{
  'definition.yml' = "name: cached`nversion: 1.0.0`ntags: [tools]`nfamily:`n- name: ai"
  'init.lua' = '-- fixture'
  'locale/en.yml' = "tags.tools: Tools`nfamily.ai: AI Behaviour"
}
try {
  $archiveHash = (Get-FileHash -Algorithm SHA256 -Path $archive).Hash.ToLowerInvariant()
  $fromArchive = { param($Uri, $OutFile) Copy-Item -LiteralPath $archive -Destination $OutFile -Force }.GetNewClosure()
  $noDownload = { param($Uri, $OutFile) throw 'unexpected download' }
  $languages = @('en', 'de')

  function New-CacheCase($Definition, $Capabilities, [hashtable]$Published, [string]$Hash) {
    $cached = @{ package = @(@{ url = 'https://example.invalid/cached.zip'; hash = $Hash }) }
    foreach ($key in $Published.Keys) { $cached[$key] = $Published[$key] }
    $hit = @{ definition = @{ name = $Definition.name; version = '1.0.0'; capabilities = $Capabilities }; contents = $cached }
    # build-store.ps1 copies the cached contents before completing discovery
    return @{ Extension = @{ definition = $Definition; contents = $hit.contents }; Hit = $hit }
  }

  # 1. Untagged package with published capabilities: carried over, no download.
  $published = @{ files = $true; code = $false; configuration = $false; options = $false }
  $case = New-CacheCase @{ name = 'plain'; version = '1.0.0' } $published @{} $archiveHash
  Complete-CachedExtensionDiscovery -Extension $case.Extension -Hit $case.Hit -Languages $languages -Download $noDownload
  Assert-Equal $case.Extension.definition.capabilities.files $true 'Keep published capabilities'
  Assert-Equal $case.Extension.contents.ContainsKey('tag-locales') $false 'No labels for an untagged package'

  # 2. Untagged package published before capabilities existed: read from the archive.
  $case = New-CacheCase @{ name = 'plain'; version = '1.0.0' } $null @{} $archiveHash
  Complete-CachedExtensionDiscovery -Extension $case.Extension -Hit $case.Hit -Languages $languages -Download $fromArchive
  Assert-Equal $case.Extension.definition.capabilities.code $true 'Capabilities read from the cached archive'
  Assert-Equal $case.Extension.contents.ContainsKey('tag-locales') $false 'Still no labels for an untagged package'

  # 3. Tagged package with capabilities but no labels: labels read, capabilities kept.
  $case = New-CacheCase @{ name = 'tagged'; version = '1.0.0'; tags = @('tools') } $published @{} $archiveHash
  Complete-CachedExtensionDiscovery -Extension $case.Extension -Hit $case.Hit -Languages $languages -Download $fromArchive
  Assert-Equal $case.Extension.contents['tag-locales'].en.tools 'Tools' 'Tag labels read from the cached archive'
  Assert-Equal $case.Extension.definition.capabilities.files $true 'Published capabilities are not replaced'

  # 4. Everything published already: nothing downloaded, labels unchanged.
  $case = New-CacheCase @{ name = 'tagged'; version = '1.0.0'; tags = @('tools') } $published @{ 'tag-locales' = @{ en = @{ tools = 'Werkzeug' } } } $archiveHash
  Complete-CachedExtensionDiscovery -Extension $case.Extension -Hit $case.Hit -Languages $languages -Download $noDownload
  Assert-Equal $case.Extension.contents['tag-locales'].en.tools 'Werkzeug' 'Published labels stay'

  # 5. Family member without family labels: read from the archive.
  $case = New-CacheCase @{ name = 'member'; version = '1.0.0'; family = @(@{ name = 'ai' }) } $published @{} $archiveHash
  Complete-CachedExtensionDiscovery -Extension $case.Extension -Hit $case.Hit -Languages $languages -Download $fromArchive
  Assert-Equal $case.Extension.contents['family-locales'].en.ai 'AI Behaviour' 'Family labels read from the cached archive'

  # 6. Wrong hash or missing package data: the build stops.
  foreach ($bad in @(
      (New-CacheCase @{ name = 'plain'; version = '1.0.0' } $null @{} ('0' * 64)),
      (New-CacheCase @{ name = 'plain'; version = '1.0.0' } $null @{} ''))) {
    $rejected = $false
    try { Complete-CachedExtensionDiscovery -Extension $bad.Extension -Hit $bad.Hit -Languages $languages -Download $fromArchive }
    catch { $rejected = $true }
    Assert-Equal $rejected $true 'Reject an unverifiable cached archive'
  }
}
finally { Remove-Item -LiteralPath $archive -Force }
Write-Output 'Packaged discovery metadata, catalog family and cached package checks passed.'
