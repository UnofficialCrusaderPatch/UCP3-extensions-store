# Derive discovery data from the actual packaged files, using the existing YAML
# dependency and .NET ZIP reader. This adds no runtime or build-tool dependency.
function Assert-ExtensionFamilyCatalog {
  param([Parameter(Mandatory = $true)]$Extensions)
  $families = @{}
  foreach ($extension in $Extensions) {
    $definition = $extension.definition
    $seen = @{}
    foreach ($membership in $definition.family) {
      if ($membership -isnot [Collections.IDictionary] -or
          $membership.name -isnot [string] -or [string]::IsNullOrWhiteSpace($membership.name) -or
          $membership.name -cne $membership.name.Trim() -or $seen.ContainsKey($membership.name) -or
          ($null -ne $membership.root -and $membership.root -isnot [bool])) {
        throw "Invalid family metadata for $($definition.name)@$($definition.version)"
      }
      $seen[$membership.name] = $true
      if (-not $families.ContainsKey($membership.name)) { $families[$membership.name] = @{ Members = @{}; Roots = @{} } }
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
  $archive = [IO.Compression.ZipFile]::OpenRead([IO.Path]::GetFullPath($ArchivePath))
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
        if ($family -isnot [Collections.IDictionary] -or $family.name -isnot [string]) { continue }
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
