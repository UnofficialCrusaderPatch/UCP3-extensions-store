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
Write-Output 'Packaged discovery metadata checks passed.'
