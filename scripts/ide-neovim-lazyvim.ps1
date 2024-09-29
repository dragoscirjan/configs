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
    # Eza https://github.com/eza-community/eza
    "eza",
    # Fd https://github.com/sharkdp/fd
    "fd",
    # FuzzyFinder https://github.com/junegunn/fzf
    "fzf",
    # Lazygit https://github.com/jesseduffield/lazygit
    "lazygit",
    # Luarocks https://luarocks.org/
    "luarocks",
    # Ripgrep https://github.com/BurntSushi/ripgrep
    "ripgrep",
    # compilers
    "cmake", "llvm", "lua", "ruby", "zig"
  ) | ForEach-Object { choco install $_ -y }

  Install-Common-Modules -PSFzf
}

function Install-Using-Scoop {
  scoop bucket add main
  scoop bucket add extras

  @(
    "main/eza",
    "main/fd",
    "main/fzf", "extras/psfzf",
    "extras/lazygit",
    "main/luarocks",
    "main/ripgrep",
    "main/cmake", "main/llvm", "main/lua", "main/ruby", "main/zig"
  ) | ForEach-Object { scoop install $_ }

  Install-Common-Modules
}

function Install-Using-Winget {
  @(
    "eza-community.eza",
    "sharkdp.fd",
    "junegunn.fzf",
    "JesseDuffield.lazygit",
    # luarocks ?
    "BurntSushi.ripgrep.MSVC",
    "Kitware.CMake", "LLVM.LLVM", "DEVCOM.Lua", "RubyInstallerTeam.Ruby.3.1", "zig.zig"
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
