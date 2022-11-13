param (
	[string]$build = "Release",
	[string]$token = "missing"
	#[Parameter(Mandatory=$true)][string]$username,
	#[string]$password = $( Read-Host "Input password, please" )
)

$buildConfiguration = $build
 
nuget sources add -Name "gynt-packages" -Source "https://nuget.pkg.github.com/gynt/index.json" -StorePasswordInClearText -Username git -Password "$token"

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

nuget sources add -Name "gynt-packages" -Source "https://nuget.pkg.github.com/gynt/index.json" -StorePasswordInClearText -Username git -Password "$token"

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