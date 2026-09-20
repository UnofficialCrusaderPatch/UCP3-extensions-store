$ErrorActionPreference = 'Stop'
$tokens = $null
$parseErrors = $null
$scriptPath = Join-Path $PSScriptRoot '../scripts/build-store.ps1'
$ast = [System.Management.Automation.Language.Parser]::ParseFile(
  (Resolve-Path $scriptPath), [ref]$tokens, [ref]$parseErrors)
if ($parseErrors.Count) { throw ($parseErrors | Out-String) }
# Execute the real cache guard without fetching, building, signing or publishing.
$guardAst = $ast.Find({ param($node)
  $node -is [System.Management.Automation.Language.IfStatementAst] -and
  $node.Extent.Text.StartsWith("if (`$extension.contents.source['rebuild-on-source-change']")
}, $true)
if ($null -eq $guardAst) { throw 'Missing source-aware binary cache guard' }
$guard = [scriptblock]::Create($guardAst.Extent.Text)

function Check-Cache($label, $requested, $cached, $expectReuse) {
  $extension = @{ contents = @{ source = $requested } }
  $hit = @{ contents = @{ source = $cached; package = 'existing-signed-package' } }
  . $guard
  if (($null -ne $hit) -ne $expectReuse) { throw "Unexpected reuse: $label" }
  if ($expectReuse -and $hit.contents.package -ne 'existing-signed-package') {
    throw "Package changed during reuse: $label"
  }
  Write-Output "PASS $label"
}
$source = @{
  method = 'github'; url = 'owner/module'; 'github-sha' = 'corrected-commit'
  'github-tag' = 'main'; 'rebuild-on-source-change' = $true
}
Check-Cache 'same source reuses signed package' $source $source.Clone() $true
foreach ($field in @('method', 'url', 'github-sha', 'location', 'extension-type')) {
  $old = $source.Clone()
  $old[$field] = 'superseded-value'
  Check-Cache "changed $field rebuilds" $source $old $false
}
$old = $source.Clone()
$old.Remove('rebuild-on-source-change')
Check-Cache 'older receipt with matching identity reuses' $source $old $true
$old['github-tag'] = 'renamed-branch-same-commit'
Check-Cache 'branch name does not override pinned identity' $source $old $true
Check-Cache 'missing cached source rebuilds' $source $null $false
$noPin = $source.Clone()
$noPin.Remove('github-sha')
Check-Cache 'missing requested pin cannot reuse' $noPin $noPin $false
$legacy = $source.Clone()
$legacy.Remove('rebuild-on-source-change')
$old['github-sha'] = 'legacy-published-pin'
Check-Cache 'unrelated legacy recipe keeps existing behavior' $legacy $old $true
