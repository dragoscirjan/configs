Param(
  [Parameter(Position=0,mandatory=$true)]
  [string]$GoVersion
)

Write-Host "Searching latest node version for: $GoVersion ..." -ForegroundColor Green

$ProgressPreference = 'SilentlyContinue'    # Subsequent calls do not display UI.

$Webpage = Invoke-WebRequest -Uri 'https://golang.org/dl/';

$ProgressPreference = 'Continue'

$Versions = ([regex]"<a .+ href=`"\/dl\/go($($GoVersion)\.\d+)").Matches($Webpage) | ForEach-Object { $_.Groups[1].Value };

# https://github.com/Mellbourn/Sort-Semver.ps1/blob/master/Sort-Semver.ps1
# Import-Module ..\.install\Sort-Semver.ps1
..\.install\Sort-Semver.ps1

Get-ChildItem -Path Function:\Sort-Semver

$LatestVersion = (Sort-Semver $Versions -Descending)[0]

$LatestVersion

Write-Host "Node version detected: $LatestVersion; Installing ..." -ForegroundColor Green

Remove-Item Function:\Sort-Semver*

..\.install\install.ps1 -Url "https://golang.org/dl/go$LatestVersion.windows-amd64.msi" `
  -File $HOME/Downloads/golang-setup.msi -ArgumentList '/quiet /passive /norestart /update'
