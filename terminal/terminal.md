# Terminal Tools

- [Terminal Tools](#terminal-tools)
  - [Default](#default)
  - [Alacritty](#alacritty)
  - [Cmder](#cmder)
  - [Ghostty](#ghostty)
  - [iTerm2](#iterm2)
  - [Kitty](#kitty)
  - [Microsoft Terminal](#microsoft-terminal)
  - [Terminus](#terminus)
  - [WezTerm](#wezterm)

## Default

```bash
# Darwin
brew install --cask alacritty wezterm ghostty

# Linux
sudo apt update && sudo apt install -y alacritty
sudo snap install wezterm --classic

curl -sSL https://github.com/mkasberg/ghostty-ubuntu/releases/download/1.0.1-0-ppa1/ghostty_1.0.1-0.ppa1_amd64_24.04.deb -o /tmp/ghostty.deb
sudo dpkg -i /tmp/ghostty.deb # see docs for config file bellow
rm -rf /tmp/ghsotty.deb

# Windows
choco install alacritty wezterm -y

scoop bucket add extras && scoop install extras/alacritty extras/wezterm

@("Alacritty.Alacritty", "WezWezterm") | ForEach-Object { winget install -e --id $_ }
```

## Alacritty

```bash
# Darwin
brew install --cask alacritty
# Linux
sudo apt install -y alacritty
# Windows
choco install alacritty -y
scoop install extras/alacritty
winget install -e --id Alacritty.Alacritty
```

## Cmder

```bash
# Darwin
# Cmder is not available on macOS.
# Linux
# Cmder is not available on Linux.
# Windows
choco install cmder -y
scoop install extras/cmder
winget install -e --id Cmder.Cmder
```

## Ghostty

```bash
# Darwin
brew install --cask ghostty
# Linux (https://ghostty.org/docs/install/binary)
curl -sSL https://github.com/mkasberg/ghostty-ubuntu/releases/download/1.0.1-0-ppa1/ghostty_1.0.1-0.ppa1_amd64_24.04.deb -o /tmp/ghostty.deb
sudo dpkg -i /tmp/ghostty.deb
rm -rf /tmp/ghsotty.deb
```

More details on the configuration file here: https://ghostty.org/docs/config

```bash
CONFIG_FILE=$HOME/.config/ghostty/config
CMD_KEY=ctrl
uname -a | grep Darwin > /dev/null \
  && CONFIG_FILE="$HOME/Library/Application Support/com.mitchellh.ghostty/config" \
  && CMD_KEY=cmd
cat > $CONFIG_FILE <<EOF
# Visuals
font-family                = "SauceCodePro Nerd Font"
font-size                  = 16
window-inherit-font-size   = true
background-opacity         = 0.9


# Tab Navigation
keybind = $CMD_KEY+right=next_tab
keybind = $CMD_KEY+left=previous_tab
EOF
cat $CONFIG_FILE
```

## iTerm2

```bash
# Darwin
brew install --cask iterm2
# Linux
# Not available on Linux.
# Windows
# Not available on Windows.
```

## Kitty

```bash
# Darwin
brew install --cask kitty
# Linux
sudo apt install -y kitty
# Windows
# Not available on Windows.
```

## Microsoft Terminal

```bash
# Darwin
# Not available on macOS.
# Linux
# Not available on Linux.
# Windows
choco install microsoft-windows-terminal -y
scoop install extras/microsoft-terminal
winget install -e --id Microsoft.WindowsTerminal
```

## Terminus

```bash
# Darwin
brew install --cask terminus
# Linux
# Terminus is not available through package manager; use AppImage or download from the website.
wget https://github.com/Eugeny/terminus/releases/download/v1.0.144/terminus-1.0.144-linux.AppImage -O terminus.AppImage
chmod +x terminus.AppImage
sudo mv terminus.AppImage /usr/local/bin/terminus
# Windows
choco install terminus -y
scoop install extras/terminus
winget install -e --id Terminus.Terminus
```

## WezTerm

```bash
# Darwin
brew install --cask wezterm
# Linux
sudo snap install wezterm --classic
# Windows
choco install wezterm -y
scoop install extras/wezterm
winget install -e --id WezWezterm
```
