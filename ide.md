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
curl -o- https://raw.githubusercontent.com/dragoscirjan/configs/main/scripts/ide-neovim-lazyvim.sh | bash
```

```powershell
#
# Windows
#

Set-ExecutionPolicy Bypass -Scope Process -Force; 
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/dragoscirjan/configs/main/scripts/ide-neovim-lazyvim.ps1'))
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
