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
  - [PyCharm](#pycharm)

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

```bash
# Darwin
brew install phpstorm
# Linux
sudo snap install phpstorm --classic
# Windows
choco install phpstorm -y
scoop bucket add extras && scoop install extras/phpstorm
winget install -e --id JetBrains.PHPStorm
```

## PyCharm

```bash
# Darwin
brew install pycharm
# Linux
sudo snap install pycharm --classic
# Windows
choco install pycharm-professiional -y
scoop bucket add extras && scoop install extras/pycharm-professiional
winget install -e --id JetBrains.PyCharm.Professiional
```

## PyCharm Community Edition

```bash
# Darwin
brew install pycharm-ce
# Linux
sudo snap install pycharm-community --classic
# Windows
choco install pycharm-community -y
scoop bucket add extras && scoop install extras/pycharm
winget install -e --id JetBrains.PyCharm.Community
```

## Rider

```bash
# Darwin
brew install rider
# Linux
sudo snap install rider --classic
# Windows
choco install jetbrains-rider resharper -y
scoop bucket add extras && scoop install extras/rider && scoop install main/resharper-clt
winget install -e --id JetBrains.Rider JetBrains.ReSharper
```

## RustRover

```bash
# Darwin
brew install rustrover
# Linux
sudo snap install rustrover --classic
# Windows
choco install rustrover -y
scoop bucket add extras && scoop install extras/rustrover 
# -- winget install -e --id JetBrains.Rider JetBrains.ReSharper
```

## Sublime

```bash
# Darwin
brew install sublime-text
# Linux
sudo snap install sublime-text sublime-merge --classic
# Windows
choco install sublimetext4 -y
scoop bucket add extras && scoop install extras/sublime-text 
winget install -e --id SublimeHQ.SublimeText.4
```

## Visual Studio

```bash
# Darwin
# -- brew install rustrover
# Linux
# -- sudo snap install rustrover --classic
# Windows
choco install visualstudio2022community -y
# -- scoop bucket add extras && scoop install extras/rustrover 
winget install -e --id Microsoft.VisualStudio.2022.Enterprise.Preview
```
## Visual Studio Community Edition

```bash
# Darwin
# -- brew install rustrover
# Linux
# -- sudo snap install rustrover --classic
# Windows
choco install visualstudio2022community -y
# -- scoop bucket add extras && scoop install extras/rustrover 
winget install -e --id Microsoft.VisualStudio.2022.Community.Preview
```
## Visual Studio Code

```bash
# Darwin
brew install visual-studio-code
# Linux
sudo snap install code --classic
# Windows
choco install vscode -y
scoop bucket add extras && scoop install extras/vscode 
winget install -e --id Microsoft.VisualStudioCode
```

## VS Codium

```bash
# Darwin
brew install vscodium
# Linux
sudo snap install codium --classic
# Windows
choco install vscodium -y
scoop bucket add extras && scoop install extras/vscodium 
winget install -e --id VSCodium.VSCodium
```

## WebStorm

```bash
# Darwin
brew install webstorm
# Linux
sudo snap install webstorm --classic
# Windows
choco install webstorm -y
scoop bucket add extras && scoop install extras/webstorm 
winget install -e --id JetBrains.WebStorm
```

## Zed

```bash
# Darwin
brew install zed
# Linux - https://zed.dev/docs/linux
curl -f https://zed.dev/install.sh | sh
# Windows - https://zed.dev/docs/windows
# You need to build it yourself...
```
