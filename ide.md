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
        - [LazyVim Config Windows](#lazyvim-config-windows)
  - [PhpStorm](#phpstorm)
  - [PyCharm](#pycharm)
  - [PyCharm Community Edition](#pycharm-community-edition)
  - [Rider](#rider)
  - [RustRover](#rustrover)
  - [Sublime Text](#sublime-text)
    - [Sublime Merge](#sublime-merge)
  - [Visual Studio](#visual-studio)
  - [Visual Studio Community Edition](#visual-studio-community-edition)
  - [Visual Studio Code](#visual-studio-code)
  - [VS Codium](#vs-codium)
  - [WebStorm](#webstorm)
  - [Zed](#zed)

## Default

```bash
# Darwin
brew install clion goland neovim visual-studio-code zed pycharm sublime-text

# Linux
sudo snap install clion goland nvim code pycharm-professional --classic
curl -f https://zed.dev/install.sh | sh
sudo apt update && sudo apt install sublime-text sublime-merge

# Windows
choco install clion-ide goland neovim vscode zed pycharm-professional sublimetext4 sublime-merge -y

scoop bucket add extras && scoop install extras/clion extras/goland extras/neovim extras/vscode extras/pycharm extras/sublime-text extras/sublime-merge

@("JetBrains.CLion", "JetBrains.GoLand", "Neovim.Neovim", "Microsoft.VisualStudioCode", "JetBrains.PyCharm.Professional", "VSCodium.VSCodium", "SublimeHQ.SublimeText.4", "SublimeHQ.SublimeMerge", "Zed.Zed") | ForEach-Object { winget install -e --id $_ }
```

## CLion

```bash
# Darwin
brew install clion
# Linux
sudo snap install clion --classic
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
# Linux Tarball
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' | sudo tee -a /etc/profile.d/nvim.sh
source /etc/profile.d/nvim.sh
```
```powershell
# Windows
choco install lua luarocks neovim -y
scoop bucket add main && scoop install main/lua main/luarocks main/neovim
winget install --id Neovim.Neovim -e
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

#### LazyVim Config

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

##### LazyVim Config Windows

**TreeSitter Compiler**

```lua
-- init.lua must contain the list of compilers for treesitter
require("config.lazy")
require("nvim-treesitter.install").compilers = { "zig", "clang" }
```

**Alacritty**

If you are using `alacritty` as terminal, here's a minimal `$env:APPDATA/alacritty/alacritty.toml` config:

```toml
[font]
size = 11.0

[font.bold]
family = "DejaVuSansM Nerd Font Mono"
style = "Bold"

[font.bold_italic]
family = "DejaVuSansM Nerd Font Mono"
style = "Bold Italic"

[font.italic]
family = "DejaVuSansM Nerd Font Mono"
style = "Italic"

[font.normal]
family = "DejaVuSansM Nerd Font Mono"
style = "Regular"
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
sudo snap install pycharm-professional --classic
# Windows
choco install pycharm-professional -y
scoop bucket add extras && scoop install extras/pycharm-professional
winget install -e --id JetBrains.PyCharm.Professional
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
winget install -e --id JetBrains.RustRover
```

## Sublime Text

```bash
# Darwin
brew install sublime-text
# Linux
sudo snap install sublime-text --classic
# Windows
choco install sublimetext4 -y
scoop bucket add extras && scoop install extras/sublime-text 
winget install -e --id SublimeHQ.SublimeText.4
```

### Sublime Merge

```bash
# Darwin
brew install sublime-merge
# Linux
sudo apt update && sudo apt install sublime-merge -y
# Windows
choco install sublime-merge -y
scoop bucket add extras && scoop install extras/sublime-merge 
winget install -e --id SublimeHQ.SublimeMerge
```

## Visual Studio

```bash
# Darwin
# -- Visual Studio is not available on macOS
# Linux
# -- Visual Studio is not available on Linux
# Windows
choco install visualstudio2022community -y
winget install -e --id Microsoft.VisualStudio.2022.Enterprise.Preview
```

## Visual Studio Community Edition

```bash
# Darwin
# -- Visual Studio is not available on macOS
# Linux
# -- Visual Studio is not available on Linux
# Windows
choco install visualstudio2022community -y
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
winget

 install -e --id VSCodium.VSCodium
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
# Linux
curl -f https://zed.dev/install.sh | sh
# Windows - https://zed.dev/docs/windows
# You need to build it yourself...
```
