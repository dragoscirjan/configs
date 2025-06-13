
# Generic link-config.ps1
param(
    [Parameter(Mandatory=$true)][string]$Source,
    [Parameter(Mandatory=$true)][string]$Destination
)

$timestamp = [Math]::Floor([decimal](Get-Date(Get-Date).ToUniversalTime()-UFormat "%s"))

$Source = $Source.Replace("__HOME__", $env:USERPROFILE);
$Destination = $Destination.Replace("__HOME__", $env:USERPROFILE);

if (-not (Test-Path $Source)) {
    Write-Error "» Source path '$Source' does not exist."
    exit 1
}

# Ensure parent directory of destination exists
$ParentDir = Split-Path -Path $Destination -Parent
if ($ParentDir -and -not (Test-Path $ParentDir)) {
    Write-Host "» Creating parent directory: $ParentDir"
    New-Item -ItemType Directory -Path $ParentDir -Force | Out-Null
} elseif ($ParentDir -and (Test-Path $ParentDir) -and -not (Get-Item $ParentDir).PSIsContainer) {
    Write-Error "» Parent path '$ParentDir' exists but is not a directory."
    exit 1
}

# Backup destination if it exists
if (Test-Path $Destination) {
    $backup = "$Destination.bak.$timestamp"
    Write-Host "» Backing up existing $Destination to $backup"
    Move-Item $Destination $backup
}

# Determine if source is file or directory
$itemType = if ((Get-Item $Source).PSIsContainer) { 'Directory' } else { 'File' }

Write-Host "» Linking $Source to $Destination as $itemType symbolic link"
New-Item -ItemType SymbolicLink -Path $Destination -Target $Source -Force
