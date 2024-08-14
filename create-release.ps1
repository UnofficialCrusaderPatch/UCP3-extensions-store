$REPO = "UnofficialCrusaderPatch/UCP3-extensions-store"

$branch = git rev-parse --abbrev-ref HEAD
$tag = "v$branch"
$releaseTags = gh --repo $REPO release list --json tagName | ConvertFrom-Json | ForEach-Object { $_.tagName }

$exists = ($releaseTags | Where-Object {$_ -eq "v$tag"} ) -ne $null

if ($exists) {
  gh release upload --repo $REPO --clobber $tag build\store.yml build\extensions\*.zip
} else {
  gh release create --repo $REPO --target $branch $tag build\store.yml build\extensions\*.zip
}