Param(
  [Parameter(Position=0,mandatory=$true)]
  [string]$PyVersion
)

Write-Host "Searching latest node version for: $PyVersion ..." -ForegroundColor Green

$ProgressPreference = 'SilentlyContinue'    # Subsequent calls do not display UI.

$Webpage = Invoke-WebRequest -Uri 'https://www.python.org/ftp/python'  ;

$ProgressPreference = 'Continue'

$Versions = ([regex]"<a href=`"($($PyVersion)[^\/]+)").Matches($webpage) | ForEach-Object { $_.Groups[1].Value };

# https://github.com/Mellbourn/Sort-Semver.ps1/blob/master/Sort-Semver.ps1
# Import-Module ..\.install\Sort-Semver.ps1
..\.install\Sort-Semver.ps1

Get-ChildItem -Path Function:\Sort-Semver

$LatestVersion = (Sort-Semver $Versions -Descending)[0]


Write-Host "Node version detected: $LatestVersion; Installing ..." -ForegroundColor Green

Remove-Item Function:\Sort-Semver*

..\.install\install.ps1 -Url "https://www.python.org/ftp/python/$LatestVersion/python-$LatestVersion-amd64.exe" `
  -File $HOME/Downloads/python-setup.exe -ArgumentList '/passive /quiet /simple'
