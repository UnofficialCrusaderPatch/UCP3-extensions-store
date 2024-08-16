function Update-Dependency-Statement-Internal {
  param (
    [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][string[]]$Dependencies
  )

  $Result = [System.Collections.Hashtable]@{}

  $Dependencies | ForEach-Object {
    $_ -match "^([a-zA-Z0-9-_]+)\s*([<>=]+)\s*([0-9.]+)$" | Out-Null

    if ($null -eq $Matches) {
      Write-Error "Invalid dependency statement: $_"
      return
    }

    $name = $Matches[1]
    $operator = $Matches[2]
    if ($operator -eq "==") {
      $operator = "="
    }
    $version = $Matches[3]
    $Result[$name] = "$operator$version"
  } | Out-Null

  Write-Output($Result)

}

function Update-Dependency-Statement {
  param (
    $Dependencies
  )

  if ($Dependencies.GetType().Name.Contains("Hashtable")) {
    Write-Debug "Already updated"
    Write-Output($Dependencies)    
  }
  else {
    Write-Debug "$($Dependencies.GetType().Name)"
    Update-Dependency-Statement-Internal $Dependencies
  }
}