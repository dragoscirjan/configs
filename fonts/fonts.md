# Fonts Installation

This document provides installation instructions for various fonts using bash scripts for macOS and Ubuntu, and PowerShell scripts for Windows. The scripts accept font URLs as arguments to download and install the fonts.

## Font List

1. **Agave**: [Download Agave](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Agave.zip)
2. **DejaVu Sans Mono**: [Download DejaVu Sans Mono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/DejaVuSansMono.zip)
3. **Fira Code**: [Download Fira Code](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip)
4. **Hasklug**: [Download Hasklug](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hasklig.zip)
5. **Inconsolata**: [Download Inconsolata](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Inconsolata.zip)
6. **Lekton Nerd**: [Download Lekton Nerd](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Lekton.zip)
7. **Lilex**: [Download Lilex](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Lilex.zip)
8. **Roboto Mono**: [Download Roboto Mono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/RobotoMono.zip)
9. **Sauce Code Pro**: [Download Sauce Code Pro](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/SourceCodePro.zip)
10. **Ubuntu Mono**: [Download Ubuntu Mono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Ubuntu.zip)

## Installation Scripts

### macOS Installation Script


```bash
bash <(curl -s https://raw.githubusercontent.com/dragoscirjan/configs/main/scripts/install-fonts-macos.sh) \
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Agave.zip \
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip
```

### Ubuntu Installation Script


```bash
bash <(curl -s https://raw.githubusercontent.com/dragoscirjan/configs/main/scripts/install-fonts-linux.sh) \
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Agave.zip \
  https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip
```

### Windows Installation Script

```powershell
$urls = @(
    'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Agave.zip',
    'https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraCode.zip'
)

$script = (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/dragoscirjan/configs/main/scripts/install-fonts-windows.ps1')
Invoke-Expression "$script -urls $($urls -join ',')"
```
