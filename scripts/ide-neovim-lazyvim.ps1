param(
  [string]$PackageManager = ''
)

# Define the list of valid package managers
$validPackageManagers = @('choco', 'scoop', 'winget')
# Check if the provided PackageManager is valid
if ($PackageManager -ne '') {
  if ($validPackageManagers -contains $PackageManager) {
    Write-Host "$PackageManager is a valid package manager."
  } else {
    Write-Host "$PackageManager is not a valid package manager. Please specify 'choco', 'scoop', or 'winget'." -ForegroundColor Red
    exit 1
  }
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
  param(
    [switch]$PSFzf
  )

  if ($PSFzf -eq $true) {
    Write-Host "Installing PSFzf" -ForegroundColor Green
    Install-Module -Name PSFzf
  }

  Write-Host "Installing Z" -ForegroundColor Green
  Install-Module -Name z -AllowClobber

  Write-Host "Installing OhMyPosh" -ForegroundColor Green
  Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))

  Write-Host "Installing Terminal Icons" -ForegroundColor Green
  Install-Module -Name Terminal-Icons -Repository PSGallery
}

function Install-Using-Choco {
  @(
    "llvm",
    "fzf",
    "ripgrep",
    "fd"
  ) | ForEach-Object { choco install $_ -y }

  Install-Common-Modules -PSFzf
}

function Install-Using-Scoop {
  scoop bucket add main
  scoop bucket add extras

  @(
    "main/llvm",
    "main/fzf",
    "extras/psfzf",
    "main/ripgrep",
    "main/fd"
  ) | ForEach-Object { scoop install $_ }

  Install-Common-Modules
}

function Install-Using-Winget {
  @(
    "LLVM.LLVM",
    "junegunn.fzf",
    "BurntSushi.ripgrep.MSVC",
    "sharkdp.fd"
  ) | ForEach-Object { winget install -e --id $_ }

  Install-Common-Modules -PSFzf
}

function Install-Using {
  param(
    [string]$PackageManager = ''
  )

  $PackageManagers = $validPackageManagers
  if ( $PackageManager -ne '' ) {
    $PackageManagers = @($PackageManager)
  }

  $PackageManagers | ForEach-Object {
    $pm = $_
    $pmExists = Get-Command -Name $pm -ErrorAction SilentlyContinue
    if ($pmExists) {
      $functionName = 'Install-Using-' + $pm.Substring(0, 1).ToUpper() + $pm.Substring(1).ToLower()
      Invoke-Expression $functionName
      exit 0
    }
  }

  Write-Host "No package manager discovered. Please install 'choco', 'scoop', or 'winget' and try again." -ForegroundColor Red
  exit 1
}

Install-Using -PackageManager $PackageManager
