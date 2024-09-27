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
# Ghostty is not natively available for Linux.

# Windows
choco install alacritty wezterm ghostty -y

scoop bucket add extras && scoop install extras/alacritty extras/wezterm extras/ghostty

@("Alacritty.Alacritty", "WezWezterm", "Ghostty.Ghostty") | ForEach-Object { winget install -e --id $_ }
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
# Linux
# Ghostty is not available for Linux.
# Windows
choco install ghostty -y
scoop install extras/ghostty
winget install -e --id Ghostty.Ghostty
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
