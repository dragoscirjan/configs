param(
    [string]$PackageManager = 'choco'
)

# Define the list of valid package managers
$validPackageManagers = @('choco', 'scoop', 'winget')
# Check if the provided PackageManager is valid
if ($validPackageManagers -contains $PackageManager) {
  Write-Host "$PackageManager is a valid package manager."
} else {
  Write-Host "$PackageManager is not a valid package manager. Please specify 'choco', 'scoop', or 'winget'." -ForegroundColor Red
  exit 1
}

# Requirements:
#
# FuzzyFinder https://github.com/junegunn/fzf?tab=readme-ov-file#installation
# PSFzf https://github.com/kelleyma49/PSFzf?tab=readme-ov-file#installation
#
# Z (Directory Jumper) https://www.powershellgallery.com/packages/z/1.1.14
#
# Ripgrep https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation
# Fd https://github.com/sharkdp/fd
#
# Oh My Posh https://ohmyposh.dev/
#
# Terminal Icons https://github.com/devblackops/Terminal-Icons

function Install-Common-Modules {
  Install-Module -Name z -AllowClobber

  Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))

  Install-Module -Name Terminal-Icons -Repository PSGallery
}

function Install-Using-Choco {
  @(
    "fzf"
    "ripgrep"
    "fd"
  ) | ForEach-Object { choco install $_ -y }

  Install-Module -Name PSFzf

  Install-Common-Modules
}

function Install-Using-Scoop {
  scoop bucket add main
  scoop bucket add extras

  @(
    "main/fzf"
    "extras/psfzf"
    "main/ripgrep"
    "main/fd"
  ) | ForEach-Object { scoop install $_ }

  Install-Common-Modules
}

function Install-Using-Winget {
  @(
    "fzf"
    "BurntSushi.ripgrep.MSVC"
    "sharkdp.fd"
  ) | ForEach-Object { winget install --id $_ }

  Install-Module -Name PSFzf

  Install-Common-Modules
}

$chocoExists = Get-Command choco -ErrorAction SilentlyContinue
if ( $PackageManager -eq 'choco' -or $chocoExists) {
  Install-Using-Choco
  exit 0
}

$scoopExists = Get-Command scoop -ErrorAction SilentlyContinue
if ( $PackageManager -eq 'scoop' -or $scoopExists) {
  Install-Using-Scoop
  exit 0
}

$wingetExists = Get-Command winget -ErrorAction SilentlyContinue
if ( $PackageManager -eq 'winget' -or $wingetExists) {
  Install-Using-Winget
  exit 0
}
