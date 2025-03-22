# UCP3 Extension Store

## Usage
Use the scripts folder

### Testing
Use this line and adjust it to your needs (sha hash)
```
.\scripts\build-store.ps1 -Certificate "..\ucp3-module-signing\ucp3-module-signing-key.pem" -IgnoreRecipeBranchMismatch $true -FrameworkTag "main" -FrameworkSha "9ada1f2709d3d647f63956cabcb99ac9eda0cc87" -Debug -Clean $false
```