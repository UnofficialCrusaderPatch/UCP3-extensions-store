$ErrorActionPreference = 'Stop'
Import-Module powershell-yaml
$store = Get-Content ./build/store.yml -Raw | ConvertFrom-Yaml
$modules = @('aic-tactics', 'aicloader', 'map-extensions', 'protocol', 'chat', 'files',
             'ucp2-legacy', 'recorder', 'ui', 'luajit', 'cffi', 'winProcHandler')
$destination = './build/aic-tactics-testing'
New-Item -ItemType Directory -Path "$destination/ucp/modules" -Force | Out-Null
$checksums = @()
foreach ($name in $modules) {
    $entry = @($store.extensions.list | Where-Object { $_.definition.name -eq $name })
    if ($entry.Count -ne 1 -or $entry[0].definition.type -ne 'module') {
        throw "Expected one module in the built store: $name"
    }
    $entry = $entry[0]
    $package = @($entry.contents.package)[0]
    $filename = "$name-$($entry.definition.version).zip"
    $archive = "./build/extensions/$filename"
    if (-not (Test-Path -LiteralPath $archive)) {
        # Reuse already released dependencies with their existing store identity.
        Invoke-WebRequest -Uri $package.url -OutFile $archive
    }
    $hash = (Get-FileHash -Algorithm SHA256 -LiteralPath $archive).Hash.ToLower()
    if ($hash -ne $package.hash -or $package.signature -notmatch '^[0-9a-fA-F]{1024}$') {
        throw "Invalid store package identity: $filename"
    }
    Copy-Item -LiteralPath $archive -Destination "$destination/ucp/modules/$filename"
    Set-Content -LiteralPath "$destination/ucp/modules/$filename.sig" -Value $package.signature -Encoding ascii
    $checksums += "$hash  ucp/modules/$filename"
}
$aic = @($store.extensions.list | Where-Object { $_.definition.name -eq 'aic-tactics' })[0]
$source = "./build/extensions/source/aic-tactics-$($aic.definition.version)"
Copy-Item -LiteralPath "$source/examples" -Destination "$destination/examples" -Recurse
Copy-Item -LiteralPath "$source/docs/compatibility-matrix.md" -Destination "$destination/AIC-TACTICS-COMPATIBILITY.md"
Copy-Item -LiteralPath './docs/aic-tactics-testing.md' -Destination "$destination/README.md"
Copy-Item -LiteralPath './build/store.yml' -Destination "$destination/store-manifest.yml"
Set-Content -LiteralPath "$destination/SHA256SUMS.txt" -Value $checksums -Encoding ascii
