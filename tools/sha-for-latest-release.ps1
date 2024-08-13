param (
   [Parameter(Mandatory=$true)][string]$Owner,
   [Parameter(Mandatory=$true)][string]$Repo
)

$latest = Invoke-RestMethod "https://api.github.com/repos/$Owner/$Repo/releases/latest"
$tag_name = $latest.tag_name
$ref = Invoke-RestMethod "https://api.github.com/repos/UnofficialCrusaderPatch/UnofficialCrusaderPatch/git/ref/tags/$tag_name"

if ($ref.object.type -eq "commit") {
  $sha = $ref.object.sha
  Write-Output $sha
} else {
  Write-Output "NA"
  throw "Not implemented when object.type != 'commit'"
}
