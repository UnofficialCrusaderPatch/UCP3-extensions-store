# Derive discovery data from the actual packaged files, using the existing YAML
# dependency and .NET ZIP reader. This adds no runtime or build-tool dependency.
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
    }
    return @{ Capabilities = $facts; TagLocales = $tagLocales }
  }
  finally { $archive.Dispose() }
}
