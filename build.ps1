param (
	[string]$Build = "Release",
	[string]$NugetToken = "missing"
	#[Parameter(Mandatory=$true)][string]$username,
	#[string]$password = $( Read-Host "Input password, please" )
)

$ep = Get-ExecutionPolicy -Scope CurrentUser
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install yaml library
if(!(Get-Module -ListAvailable -Name powershell-yaml)) {
  Install-Module powershell-yaml -Scope CurrentUser -Force  
}

Import-Module powershell-yaml

Set-ExecutionPolicy "$ep" -Scope CurrentUser

$buildConfiguration = $Build
 
nuget sources add -Name "gynt-packages" -Source "https://nuget.pkg.github.com/gynt/index.json" -StorePasswordInClearText -Username git -Password "$NugetToken"


# Set up the directories
New-Item -Name "build" -ItemType "directory" -Force
## Remove old directory for the current build configuration
Get-ChildItem -Directory -Path "build" | Where({$_.Name -eq "$buildConfiguration"}) | Remove-Item -Recurse -Force
## Create the new directory
$buildPath = (New-Item -Path "build" -Name "$buildConfiguration" -ItemType "directory").FullName
$modulesPath = "."

# Modules that should be compiled do not inherit the Secure build configurations
$simpleBuildConfiguration=$buildConfiguration
if($buildConfiguration -eq "DebugSecure") {
	$simpleBuildConfiguration="Debug"
}
if($buildConfiguration -eq "ReleaseSecure") {
	$simpleBuildConfiguration="Release"
}


$releaseNames = @{
  ReleaseSecure = "";
  Release = "dev";
}

$UCP3SrcDirName = (Get-Item "UnofficialCrusaderPatch3*").Name

# UNDO: fixme: this is a hack for now to emulate a UCP3 repo without modules
Get-ChildItem -Directory | Where({$_.Name -ne "$UCP3SrcDirName"}) | Where({$_.Name -match ".*?-[0-9].[0-9].[0-9]$"}) | Remove-Item -Recurse -Force
Move-Item -Path "$UCP3SrcDirName\content\ucp\modules\*" -Destination "."


# Compile UCP3
pushd UnofficialCrusaderPatch3*

.\build.ps1 -Build "$buildConfiguration" -NugetToken "$NugetToken"

popd

Move-Item -Path "UnofficialCrusaderPatch3*\$buildConfiguration\ucp-package\*" -Destination "$buildPath\$UCP3SrcDirName"


# Compile the modules


# List all modules to compile, ignore a build directory and any directory starting with a ".", and ignoring the UnofficialCrusaderPatch3 module
[array]$moduleDirectories = Get-ChildItem -Path $modulesPath -Directory | Where({$_.Name -ne "build"}) | Where({!$_.Name.StartsWith(".")})  | Where({!$_.Name.StartsWith("UnofficialCrusaderPatch3")})

foreach($moduleDirectory in $moduleDirectories) {
	$moduleFullName = $moduleDirectory.Name
	$modulePath = $moduleDirectory.FullName
	$moduleDestinationPath = "$buildPath\$moduleFullName"
	
	New-Item -ItemType "Directory" $moduleDestinationPath
	
	  # If the module uses C++ we have to build it first
	[array]$slnFilePaths = Get-ChildItem -Recurse -Path "$modulePath\*.sln"
	
	  # Build the module
	foreach($slnFilePath in $slnFilePaths) {
		pushd $slnFilePath.Directory.FullName
		nuget restore
		msbuild /m /p:Configuration=$simpleBuildConfiguration
		popd
	}
		  
	# If the module specifies a custom list of files to include, read that
	$hasFilesXML = Test-Path -Path "$modulePath\files.xml"
	if($hasFilesXML) {
		$defaultFilesNode = Select-Xml -XPath "/module/files[not(@build)]" -Path "$modulePath\files.xml"
		$buildFilesNode = Select-Xml -XPath "/module/files[@build='$simpleBuildConfiguration']" -Path "$modulePath\files.xml"
		
		$node = $null
		if($buildFilesNode) {
		  $node = $buildFilesNode
		} elseif ($defaultFilesNode) {
		  $node = $defaultFilesNode
		} else {
		  Throw "Invalid files.xml in module: $moduleFullName"
		}
		
		[array]$moduleFiles = $node.Node.file
		foreach($moduleFile in $moduleFiles) {
		  # To allow specification of $(Configuration) in "src" in module.files, we substitute it with the right value here
		  $srcFile = $moduleFile.src.Replace("`$(Configuration)", "$simpleBuildConfiguration")
		  
		  $target = $null
		  if($moduleFile.target -eq $null) {
			$target = "./"
		  } else {
			$target = $moduleFile.target
		  }
		  
		  pushd "$modulePath"
		  
		  [array]$validPaths = Resolve-Path "$srcFile" -Relative | Where({!$_.Contains("..")})
		  
		  if( ( $validPaths.Count -gt 1 ) -or ( $target.EndsWith("/") ) ) {
			  # Source is a list of files, target is a directory
			  if (!(Test-Path -path "$moduleDestinationPath\$target\")) {
				New-Item "$moduleDestinationPath\$target\" -Type Directory
			  }
			  $validPaths | Copy-Item -Destination "$moduleDestinationPath\$target" -Recurse
		  } else {
			  # Source is a single file or folder, and the target is a single file
			  $validPaths | Copy-Item -Destination "$moduleDestinationPath\$target" -Recurse
		  }
		  
		  popd
		  
		}
		
	} else {
		# TODO: avoid this wildcard. Include .lua .yml and ... only?
		Copy-Item ("$modulePath\*") -Destination "$moduleDestinationPath" -Recurse
	}
}



pushd $buildPath
[array]$buildModuleDirectories = Get-ChildItem -Directory | ForEach-Object {$_.Name}
foreach($bmd in $buildModuleDirectories) {
	7z a "$bmd.zip" "./$bmd/*"
}

Get-Item "*.zip" | ForEach-Object { $h = Get-FileHash $_ -Algorithm SHA256; $n = $_.Name; New-Item -Name "$n.sig" -Value "$($h.Hash)" }

popd





pushd $buildPath

[System.Collections.ArrayList]$hashedEntries = @()
Get-Item *.sig | ForEach-Object { 
  $h = Get-Content $_; 
  $n = ($_.Name -Split ".zip.sig")[0];
  
  
  $def = @{};
  if(Test-Path "$n\definition.yml") {
    $def = Get-Item "$n\definition.yml" | Get-Content | ConvertFrom-Yaml
  }
  
  $nz = "$($n).zip"
  $hashedEntries.Add([ordered]@{
    extension = $n; 
    file = $nz;
    hash = $h.ToString();
    header = $def;
  }) 
}

ConvertTo-Yaml $hashedEntries | Set-Content -Path "$buildPath\meta.yml"
ConvertTo-Json $hashedEntries | Set-Content -Path "$buildPath\meta.json"

popd
