# IDEs

- [IDEs](#ides)
  - [Default](#default)
  - [CLion](#clion)
  - [Fleet](#fleet)
  - [Goland](#goland)
  - [IntelliJ IDEA](#intellij-idea)
  - [IntelliJ IDEA Community Edition](#intellij-idea-community-edition)
  - [Neovim](#neovim)
    - [LazyVim](#lazyvim)
        - [LazyVim Config](#lazyvim-config)
  - [PhpStorm](#phpstorm)

## Default

```bash
# Darwin
brew install clion goland

# Linux
sudo snap install clion goland --classic
```

```powershell
# Windows
choco install clion-ide goland -y

scoop bucket add extras && scoop install extras/clion extras/goland

@("JetBrains.CLion", "JetBrains.GoLand") | ForEach-Object { winget install -e --id $_ }
```

## CLion

```bash
# Darwin
brew install clion
# Linux
sudo snap install clion goland --classic
# Windows
choco install clion-ide -y
scoop bucket add extras && scoop install extras/clion
winget install -e --id JetBrains.CLion
```

## Fleet

```bash
# TODO
```
  
## Goland

```bash

# Darwin
brew install goland
# Linux
sudo snap install goland --classic
# Windows
choco install goland -y
scoop bucket add extras && scoop install extras/goland
winget install -e --id JetBrains.GoLand
```
## IntelliJ IDEA

```bash
# Darwin
brew install intellij-idea
# Linux
sudo snap install intellij-idea-ultimate --classic
# Windows
choco install intellijidea-ultimate -y
scoop bucket add extras && scoop install extras/idea-ultimate
winget install -e --id JetBrains.IntelliJIDEA.Ultimate
```
## IntelliJ IDEA Community Edition

```bash
# Darwin
brew install intellij-idea-ce
# Linux
sudo snap install intellij-idea-community --classic
# Windows
choco install intellijidea-community -y
scoop bucket add extras && scoop install extras/idea
winget install -e --id JetBrains.IntelliJIDEA.Community
```

## Neovim

For more details, please see the [Neovim Install Page](https://github.com/neovim/neovim/blob/master/INSTALL.md#linux).

```bash
# Darwin
brew install neovim neovim-qt
```
```bash
# Linux Snap
sudo snap install nvim --classic
# Linux 
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

cat ~/.bashrc | grep nvim 2>/dev/null || echo "export PATH=\"$PATH:/opt/nvim-linux64/bin\"" >> ~/.bashrc
soruce ~/.bashrc
```
```powershell
# Windows
choco install lua luarocks neovim -y
scoop bucket add main && scoop install main/lua main/luarocks main/neovim
# winget install --id Neovim.Neovim
```

### LazyVim

LazyVim's implementation is based on [Takuya Matsuyama](https://dev.to/craftzdog)'s [article](https://dev.to/craftzdog/my-neovim-setup-for-react-typescript-tailwind-css-etc-58fb) and [configuration](https://github.com/craftzdog/dotfiles-public)

```bash
#
# Darwin & Linux
#

# Fish Shell https://fishshell.com/
#
uname -a | grep Darwin 2>/dev/null \
  && brew install fish

if [[ -f /etc/os-release ]]; then
  . /etc/os-release

  # https://launchpad.net/~fish-shell/+archive/ubuntu/release-3
  if [[ "$ID" == "ubuntu" ]]; then
    sudo apt-add-repository ppa:fish-shell/release-3 \
      && sudo apt update \
      && sudo apt install fish
  fi

  # Fedora 40 https://software.opensuse.org/download.html?project=shells%3Afish%3Arelease%3A3&package=fish
  if [[ "$ID" == "fedora" ]]; then
    sudo dnf config-manager --add-repo https://download.opensuse.org/repositories/shells:fish:release:3/Fedora_40/shells:fish:release:3.repo \
      && dnf install fish
  fi
fi

# FuzzyFinder https://github.com/junegunn/fzf?tab=readme-ov-file#installation
#
uname -a | grep Darwin 2>/dev/null \
  && brew install fzf
which apk 2>/dev/null && sudo apk add fzf
which apt 2>/dev/null && sudo apt install fzf -y
which dnf 2>/dev/null && sudo dnf install fzf -y

# Z (Directory Jumper) for Fish shell https://github.com/jethrokuan/z
#
which fisher 2>/dev/null && fisher install jethrokuan/z
```

```powershell
#
# Windows
#

# FuzzyFinder https://github.com/junegunn/fzf?tab=readme-ov-file#installation
#
Get-Command choco && choco install fzf -y
Get-Command scoop && scoop bucket add main && scoop install main/fzf
Get-Command winget && winget install --id fzf

# PSFzf https://github.com/kelleyma49/PSFzf?tab=readme-ov-file#installation
#
Get-Command scoop && scoop bucket add extras && scoop install extras/psfzf
# or
Get-Command scoop || Install-Module -Name PSFzf

# Z (Directory Jumper) https://www.powershellgallery.com/packages/z/1.1.14
#
Install-Module -Name z # -AllowClobber

# Ripgrep https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation
Get-Command choco && choco install ripgrep -y
Get-Command scoop && scoop bucket add main && scoop install main/ripgrep
Get-Command winget && winget install --id BurntSushi.ripgrep.MSVC

# Fd https://github.com/sharkdp/fd
Get-Command choco && choco install fd -y
Get-Command scoop && scoop bucket add main && scoop install fd
Get-Command winget && winget install --id sharkdp.fd

# Oh My Posh https://ohmyposh.dev/
#
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))

# Terminal Icons https://github.com/devblackops/Terminal-Icons
#
Install-Module -Name Terminal-Icons -Repository PSGallery
```

##### LazyVim Config

```bash
# Darwin
git clone https://github.com/dragoscirjan/neovim-config ~/.config/nvim
```
```bash
# Linux
git clone https://github.com/dragoscirjan/neovim-config ~/.config/nvim
```
```powershell
git clone https://github.com/dragoscirjan/neovim-config $env:LOCALAPPDATA/nvim
```

## PhpStorm
  {
    name: "phpstorm",
    installers: {
      brew: ["phpstorm"],
      choco: ["phpstorm"],
      scoop: ["extras/phpstorm"],
      snap: ["classic/phpstorm"],
      winget: ["JetBrains.PHPStorm"],
    },
    type: "ide",
  },
  {
    default: true,
    name: "pycharm",
    installers: {
      brew: ["pycharm"],
      choco: ["pycharm"],
      scoop: ["extras/pycharm-professional"],
      snap: ["classic/pycharm-professional"],
      winget: ["JetBrains.PyCharm.Professional"],
    },
    type: "ide",
  },
  {
    name: "pycharm-ce",
    installers: {
      brew: ["pycharm-ce"],
      choco: ["pycharm-community"],
      scoop: ["extras/pycharm"],
      snap: ["classic/pycharm-community"],
      winget: ["JetBrains.PyCharm.Community"],
    },
    type: "ide",
  },
  {
    name: "rider",
    installers: {
      brew: ["rider"],
      choco: ["jetbrains-rider", "resharper"],
      scoop: ["extras/rider", "main/resharper-clt"],
      snap: ["classic/rider"],
      winget: ["JetBrains.Rider", "JetBrains.ReSharper"],
    },
    type: "ide",
  },
  {
    default: true,
    name: "rustrover",
    installers: {
      brew: ["rustrover"],
      choco: ["rustrover"],
      snap: ["classic/rustrover"],
    },
    type: "ide",
  },
  {
    default: true,
    name: "sublime",
    installers: {
      brew: ["sublime-text"],
      choco: ["sublimetext4 --pre"],
      scoop: ["extras/sublime-text"],
      snap: ["classic/sublime-text", "classic/sublime-merge"],
      winget: ["SublimeHQ.SublimeText.4"],
    },
    type: "ide",
  },
  {
    name: "visual-studio",
    installers: {
      choco: ["visualstudio2022community"],
      winget: ["Microsoft.VisualStudio.2022.Enterprise.Preview"],
    },
    type: "ide",
  },
  {
    name: "visual-studio-ce",
    installers: {
      choco: ["visualstudio2022community"],
      winget: ["Microsoft.VisualStudio.2022.Community.Preview"],
    },
    type: "ide",
  },
  {
    default: true,
    name: "vscode",
    installers: {
      brew: ["visual-studio-code"],
      choco: ["vscode"],
      scoop: ["extras/vscode"],
      snap: ["classic/code"],
      winget: ["Microsoft.VisualStudioCode"],
    },
    type: "ide",
  },
  {
    default: true,
    name: "vscodium",
    installers: {
      brew: ["vscodium"],
      scoop: ["extras/vscodium"],
      snap: ["classic/codium"],
      winget: ["VSCodium.VSCodium"],
    },
    type: "ide",
  },
  {
    default: true,
    name: "webstorm",
    installers: {
      brew: ["webstorm"],
      choco: ["webstorm"],
      scoop: ["extras/webstorm"],
      snap: ["classic/webstorm"],
      winget: ["JetBrains.WebStorm"],
    },
    type: "ide",
  },
  {
    default: true,
    name: "zed",
    installers: {
      brew: ["zed"],
    },
    type: "ide",
  },
