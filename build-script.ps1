$REPO = "UnofficialCrusaderPatch/UCP3-extensions-store"
$STORE_FILE_NAME = "store.yml"

# Install yaml library
if (!(Get-Module -ListAvailable -Name powershell-yaml)) {
  Install-Module powershell-yaml -Scope CurrentUser -Force  
}

Import-Module powershell-yaml

$recipe = Get-Content .\recipe.yml | ConvertFrom-Yaml
$store = Get-Content .\recipe.yml | ConvertFrom-Yaml

$releaseTags = gh --repo $REPO release list --json tagName | ConvertFrom-Json | ForEach-Object { $_.tagName }

# For testing only
$releaseTags = "['v3.0.0', 'v3.0.1', 'v3.0.2']" | ConvertFrom-Yaml

# Descending order
$sortedReleaseVersionsArray = $releaseTags | Where-Object { $_.StartsWith("v") } | ForEach-Object { [semver]($_.Substring(1)) } | Sort-Object -Descending

$extensions = $recipe.extensions.list

$resolvedExtensions = [System.Collections.ArrayList]::new()

$extensionsToBeBuilt = $extensions | ForEach-Object { $_ } # Array copy

foreach ($release in $sortedReleaseVersionsArray) {

  if (0 -eq $extensionsToBeBuilt.Count) {
    Write-Output "All extension were resolved"
    break
  }

  $tag = "v$release"

  Write-Output "Searching for binaries in release: $tag"

  $releaseStore = gh release download $tag --pattern $STORE_FILE_NAME --repo $REPO --output - | ConvertFrom-Json

  foreach ($extension in $extensions) {

    if (0 -eq $extensionsToBeBuilt.Count) {
      Write-Output "All extension were resolved"
      break
    }

    if ($resolvedExtensions.Contains($extension)) {
      continue
    }

    $name = $extension.definition.name
    $version = $extension.definition.version
    
    Write-Output "Looking for a binary for: $name@$version"

    $hit = $releaseStore | Where-Object { $_.definition.name -eq $name } | Where-Object { $_.definition.version -eq $version }

    if ($null -ne $hit) {
      Write-Output "Found a binary"
      # Copy over the contents
      $extension.contents = $hit.contents

      $extensionsToBeBuilt.Remove($extension)
      $resolvedExtensions.Add($extension)

      continue
    }

  }

  Write-Output "Finished searching this release"
}

Write-Output "Compiling $($extensionsToBeBuilt.Count) extensions"

