# Derive discovery data from the actual packaged files, using the existing YAML
# dependency and .NET ZIP reader. This adds no runtime or build-tool dependency.
# Windows PowerShell 5.1 does not load the ZIP types by default (PowerShell 7 does).
Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem

# True when a package lists family IDs that differ only in case ("ai" and "AI").
# The launcher would treat them as two families, but powershell-yaml reads locale
# files and the Store catalog into case-insensitive hashtables, so their labels
# would collapse into one. Such packages are refused instead.
function Test-FamilyIdCaseCollision($Family) {
  $ids = @($Family | Where-Object { $_ -is [Collections.IDictionary] -and $_['name'] -is [string] } |
    ForEach-Object { $_['name'].Trim() })
  $ordinal = @($ids | Sort-Object -CaseSensitive -Unique).Count
  $ignoringCase = @($ids | Sort-Object -Unique).Count
  return $ordinal -ne $ignoringCase
}

function Assert-ExtensionFamilyCatalog {
  param([Parameter(Mandatory = $true)]$Extensions)
  # Same rules as the launcher's normalizeFamilies/groupFamilies: `family` is a
  # list of mappings with the exact keys `name` (string) and optional `root`
  # (boolean), and family IDs and package names are compared case-sensitively
  # (PowerShell's default hashtables, also those from ConvertFrom-Yaml, are not).
  $families = [hashtable]::new([StringComparer]::Ordinal)
  foreach ($extension in $Extensions) {
    $definition = $extension.definition
    if ($null -eq $definition.family) { continue }
    if ($definition.family -isnot [Collections.IList]) {
      throw "Invalid family metadata for $($definition.name)@$($definition.version): family must be a list"
    }
    if (Test-FamilyIdCaseCollision $definition.family) {
      throw "Invalid family metadata for $($definition.name)@$($definition.version): family IDs differ only in case"
    }
    $seen = [hashtable]::new([StringComparer]::Ordinal)
    foreach ($membership in $definition.family) {
      $keys = if ($membership -is [Collections.IDictionary]) { @($membership.Keys | ForEach-Object { [string]$_ }) } else { @() }
      # The launcher reads exactly `name` and `root`; `Name:` or `Root:` would be ignored there.
      $misspelled = @($keys | Where-Object { ($_ -ieq 'name' -or $_ -ieq 'root') -and $_ -cne 'name' -and $_ -cne 'root' })
      if ($membership -isnot [Collections.IDictionary] -or $misspelled.Count -gt 0 -or $keys -cnotcontains 'name' -or
          $membership['name'] -isnot [string] -or [string]::IsNullOrWhiteSpace($membership['name']) -or
          $membership['name'] -cne $membership['name'].Trim() -or $seen.ContainsKey($membership['name']) -or
          ($keys -ccontains 'root' -and $membership['root'] -isnot [bool])) {
        throw "Invalid family metadata for $($definition.name)@$($definition.version)"
      }
      $seen[$membership.name] = $true
      if (-not $families.ContainsKey($membership.name)) {
        $families[$membership.name] = @{
          Members = [hashtable]::new([StringComparer]::Ordinal)
          Roots = [hashtable]::new([StringComparer]::Ordinal)
        }
      }
      $family = $families[$membership.name]
      $family.Members[$definition.name] = $true
      if ($membership.root -eq $true) { $family.Roots[$definition.name] = $true }
    }
  }
  foreach ($name in $families.Keys) {
    if ($families[$name].Roots.Count -ne 1 -or $families[$name].Members.Count -lt 2) {
      throw "Family '$name' needs one root identity and at least two configuration identities"
    }
  }
}

function Get-ExtensionDiscoveryMetadata {
  param(
    [Parameter(Mandatory = $true)][string]$ArchivePath,
    [Parameter(Mandatory = $true)][string[]]$Languages
  )
  # Resolve against PowerShell's location; .NET would use the process directory.
  $fullPath = (Resolve-Path -LiteralPath $ArchivePath -ErrorAction Stop).ProviderPath
  $archive = [IO.Compression.ZipFile]::OpenRead($fullPath)
  try {
    function Read-PackagedYaml([string]$Name) {
      $entry = $archive.GetEntry($Name)
      if ($null -eq $entry) { return @{} }
      $reader = [IO.StreamReader]::new($entry.Open(), [Text.Encoding]::UTF8, $true)
      try {
        $parsed = ConvertFrom-Yaml -Yaml $reader.ReadToEnd()
        if ($parsed -is [Collections.IDictionary]) { return $parsed }
        return @{}
      }
      finally { $reader.Dispose() }
    }
    function Has-ConfigurationDemand($Node) {
      if ($Node -isnot [Collections.IDictionary]) { return $false }
      if ($Node.Contains('contents')) { return $true }
      foreach ($value in $Node.Values) {
        if (Has-ConfigurationDemand $value) { return $true }
      }
      return $false
    }
    $definition = Read-PackagedYaml 'definition.yml'
    if (Test-FamilyIdCaseCollision $definition.family) {
      throw "Family IDs that differ only in case in $ArchivePath; their labels cannot be kept apart"
    }
    $config = Read-PackagedYaml 'config.yml'
    $options = Read-PackagedYaml 'options.yml'
    $sparse = $config['config-sparse']
    $configuration = $false
    if ($sparse -is [Collections.IDictionary]) {
      $configuration = (Has-ConfigurationDemand $sparse['modules']) -or (Has-ConfigurationDemand $sparse['plugins'])
    }
    $facts = @{
      files = @($archive.Entries | Where-Object { $_.FullName.StartsWith('resources/', [StringComparison]::Ordinal) }).Count -gt 0
      code = $null -ne $archive.GetEntry('init.lua')
      configuration = $configuration
      options = @($options['options'] | Where-Object { $null -ne $_ }).Count -gt 0
    }
    $tagLocales = @{}
    $familyLocales = @{}
    foreach ($language in $Languages) {
      $locale = Read-PackagedYaml "locale/$language.yml"
      $labels = @{}
      foreach ($tag in $definition.tags) {
        if ($tag -isnot [string]) { continue }
        $id = $tag.Normalize([Text.NormalizationForm]::FormKC).Trim().ToLowerInvariant()
        if ($id -eq '') { continue }
        $label = $locale["tags.$id"]
        if (($label -is [string]) -and -not [string]::IsNullOrWhiteSpace($label)) {
          $labels[$id] = $label.Trim()
        }
      }
      if ($labels.Count -gt 0) { $tagLocales[$language] = $labels }
      $familyLabels = @{}
      foreach ($family in $definition.family) {
        if ($family -isnot [Collections.IDictionary] -or @($family.Keys) -cnotcontains 'name' -or
            $family['name'] -isnot [string]) { continue }
        foreach ($id in @($family.name.Trim(), "$($family.name.Trim()).configuration")) {
          $label = $locale["family.$id"]
          if (($label -is [string]) -and -not [string]::IsNullOrWhiteSpace($label)) {
            $familyLabels[$id] = $label.Trim()
          }
        }
      }
      if ($familyLabels.Count -gt 0) { $familyLocales[$language] = $familyLabels }
    }
    return @{ Capabilities = $facts; TagLocales = $tagLocales; FamilyLocales = $familyLocales }
  }
  finally { $archive.Dispose() }
}

# A recipe entry is reused from a published Store release ($Hit; build-store.ps1 has
# already copied $Hit.contents into $Extension.contents). Keep the discovery facts
# published with it; if capabilities, or tag/family labels the definition asks for, are
# missing (entries published before discovery metadata existed), read them from the
# exact published archive after checking its SHA-256. The package itself is reused
# unchanged. $Download only exists so tests can supply the archive.
function Complete-CachedExtensionDiscovery {
  param(
    [Parameter(Mandatory = $true)]$Extension,
    [Parameter(Mandatory = $true)]$Hit,
    [Parameter(Mandatory = $true)][string[]]$Languages,
    [scriptblock]$Download = { param($Uri, $OutFile) Invoke-WebRequest -Uri $Uri -OutFile $OutFile | Out-Null }
  )
  $definition = $Extension.definition
  $label = "$($definition.name)@$($definition.version)"
  $tagged = @($definition.tags | Where-Object { $null -ne $_ }).Count -gt 0
  $inFamily = @($definition.family | Where-Object { $null -ne $_ }).Count -gt 0
  # Capabilities are owned by the exporter, never by the package's own definition.
  $definition.capabilities = $Hit.definition.capabilities
  $needCapabilities = $null -eq $definition.capabilities
  $needTags = $tagged -and $null -eq $Extension.contents['tag-locales']
  $needFamily = $inFamily -and $null -eq $Extension.contents['family-locales']
  if (-not ($needCapabilities -or $needTags -or $needFamily)) { return }
  $binary = @($Hit.contents.package) | Select-Object -First 1
  if ($null -eq $binary -or [string]::IsNullOrWhiteSpace($binary.url) -or
      [string]::IsNullOrWhiteSpace($binary.hash)) {
    throw "Cached package metadata is incomplete for $label"
  }
  $cachedArchive = [IO.Path]::GetTempFileName()
  try {
    & $Download $binary.url $cachedArchive
    $actualHash = (Get-FileHash -Algorithm SHA256 -Path $cachedArchive).Hash.ToLowerInvariant()
    if ($actualHash -cne ([string]$binary.hash).ToLowerInvariant()) {
      throw "Cached package hash mismatch for $label"
    }
    $discovery = Get-ExtensionDiscoveryMetadata -ArchivePath $cachedArchive -Languages $Languages
    # Fill in only what is missing; facts and labels already published stay as they are.
    if ($needCapabilities) { $definition.capabilities = $discovery.Capabilities }
    if ($needTags) { $Extension.contents['tag-locales'] = $discovery.TagLocales }
    if ($needFamily) { $Extension.contents['family-locales'] = $discovery.FamilyLocales }
  }
  finally { Remove-Item -LiteralPath $cachedArchive -Force -ErrorAction Ignore }
}
