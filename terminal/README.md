# Terminal Tools

- [Terminal Tools](#terminal-tools)
  - [Installation](#installation)
    - [Default Set](#default-set)
    - [Individual Terminals](#individual-terminals)
      - [Alacritty](#alacritty)
      - [Ghostty](#ghostty)
      - [WezTerm](#wezterm)
      - [iTerm2](#iterm2)
      - [Microsoft Terminal](#microsoft-terminal)
      - [Kitty](#kitty)
      - [Cmder](#cmder)
      - [Terminus](#terminus)
      - [Warp](#warp)
  - [Configuration](#configuration)
    - [Alacritty Configuration](#alacritty-configuration)
    - [Ghostty Configuration](#ghostty-configuration)
    - [WezTerm Configuration](#wezterm-configuration)
  - [Features Comparison](#features-comparison)
    - [Tab Support](#tab-support)
    - [Split Panes](#split-panes)
    - [Cross-Platform Compatibility](#cross-platform-compatibility)

## Installation

### Default Set

To install the recommended terminal applications (Alacritty, WezTerm, and Ghostty):

```bash
# Install default terminals using Task
task default
```

### Individual Terminals

#### Alacritty

```bash
# Install Alacritty using Task
task alacritty
```

**Manual Installation:**
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

#### Ghostty

```bash
# Install Ghostty using Task
task ghostty
```

**Manual Installation:**
```bash
# Darwin
brew install --cask ghostty
# Linux (https://ghostty.org/docs/install/binary)
curl -sSL https://github.com/mkasberg/ghostty-ubuntu/releases/download/1.0.1-0-ppa1/ghostty_1.0.1-0.ppa1_amd64_24.04.deb -o /tmp/ghostty.deb
sudo dpkg -i /tmp/ghostty.deb
rm -rf /tmp/ghostty.deb
```

#### WezTerm

```bash
# Install WezTerm using Task
task wezterm
```

**Manual Installation:**
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

#### iTerm2

```bash
# Install iTerm2 using Task (macOS only)
task iterm
```

**Manual Installation:**
```bash
# Darwin
brew install --cask iterm2
# Linux - Not available
# Windows - Not available
```

#### Microsoft Terminal

```bash
# Install Microsoft Terminal using Task (Windows only)
task terminal
```

**Manual Installation:**
```bash
# Darwin - Not available
# Linux - Not available
# Windows
choco install microsoft-windows-terminal -y
scoop install extras/microsoft-terminal
winget install -e --id Microsoft.WindowsTerminal
```

#### Kitty

**Manual Installation:**
```bash
# Darwin
brew install --cask kitty
# Linux
sudo apt install -y kitty
# Windows - Not available
```

#### Cmder

**Manual Installation:**
```bash
# Darwin - Not available
# Linux - Not available
# Windows
choco install cmder -y
scoop install extras/cmder
winget install -e --id Cmder.Cmder
```

#### Terminus

**Manual Installation:**
```bash
# Darwin
brew install --cask terminus
# Linux
wget https://github.com/Eugeny/terminus/releases/download/v1.0.144/terminus-1.0.144-linux.AppImage -O terminus.AppImage
chmod +x terminus.AppImage
sudo mv terminus.AppImage /usr/local/bin/terminus
# Windows
choco install terminus -y
scoop install extras/terminus
winget install -e --id Terminus.Terminus
```

#### Warp

```bash
# Install Warp using Task
task warp
```

**Manual Installation:**
```bash
# Darwin
brew install --cask warp
# Linux - Check https://www.warp.dev/linux-terminal for installation steps
# Windows
winget install -e --id Warp.Warp
choco install warp -y
scoop install warp
```

## Configuration

### Alacritty Configuration

To use the predefined Alacritty configuration:

```bash
# Link Alacritty configuration
task alacritty:config
```

This will create a symbolic link to the Alacritty configuration file:
- **macOS/Linux**: `~/.config/alacritty/alacritty.toml`
- **Windows**: `~/AppData/Roaming/alacritty/alacritty.toml`

**Key Features:**
- Cross-platform key bindings
- SauceCodePro Nerd Font configuration
- macOS-exclusive tab support (commented out for other platforms)
- Consistent visual settings across terminals

### Ghostty Configuration

To use the predefined Ghostty configuration:

```bash
# Link Ghostty configuration
task ghostty:config
```

This will create a symbolic link to the Ghostty configuration file:
- **macOS**: `~/Library/Application Support/com.mitchellh.ghostty/config`
- **Linux**: `~/.config/ghostty/config`

**Key Features:**
- Tab navigation with `super+left/right`
- Direct tab access with `super+1-9`
- Tab renaming with `super+shift+r`
- Split panel support
- Shell launcher shortcuts

### WezTerm Configuration

To use the predefined WezTerm configuration:

```bash
# Link WezTerm configuration
task wezterm:config
```

This will create a symbolic link to the WezTerm configuration file:
- **All platforms**: `~/.wezterm.lua`

**Key Features:**
- Cross-platform SUPER key detection (CMD on macOS, CTRL elsewhere)
- Automatic shell detection and launcher menu
- Tab management with rename functionality
- Split pane support
- Multi-shell support (zsh, bash, fish, nushell, PowerShell)

## Features Comparison

### Tab Support

| Terminal | Tab Support | Platform Notes |
|----------|-------------|----------------|
| **Alacritty** | macOS only | Limited tab functionality |
| **Ghostty** | Full support | Native tab support across platforms |
| **WezTerm** | Full support | Rich tab management features |
| **iTerm2** | Full support | macOS exclusive |

### Split Panes

| Terminal | Split Support | Implementation |
|----------|---------------|----------------|
| **Alacritty** | None | Use tmux/screen |
| **Ghostty** | Native | Built-in split commands |
| **WezTerm** | Native | Comprehensive pane management |
| **iTerm2** | Native | Advanced split features |

### Cross-Platform Compatibility

| Terminal | macOS | Linux | Windows |
|----------|-------|-------|---------|
| **Alacritty** | ✅ | ✅ | ✅ |
| **Ghostty** | ✅ | ✅ | ❌ |
| **WezTerm** | ✅ | ✅ | ✅ |
| **iTerm2** | ✅ | ❌ | ❌ |
| **Microsoft Terminal** | ❌ | ❌ | ✅ |
| **Kitty** | ✅ | ✅ | ❌ |

**Recommended Setup:**
- **Cross-platform**: Alacritty + WezTerm
- **macOS power users**: Ghostty + iTerm2
- **Windows users**: WezTerm + Microsoft Terminal
- **Linux users**: Ghostty + WezTerm + Alacritty
