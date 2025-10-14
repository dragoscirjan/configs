# Design Tools

- [Design Tools](#design-tools)
  - [Default](#default)
  - [Figma](#figma)
  - [GIMP](#gimp)
  - [Inkscape](#inkscape)
  - [Sketch](#sketch)

## Default

```bash
# Darwin
brew install --cask gimp figma

# Linux
sudo apt update && sudo apt install -y gimp
# Figma is not natively available on Linux; consider using a web version or AppImage.

# Windows
choco install gimp figma -y

scoop bucket add extras && scoop install extras/gimp extras/figma

@("GIMP.GIMP", "Figma.Figma") | ForEach-Object { winget install -e --id $_ }
```

## Figma

```bash
# Darwin
brew install --cask figma
# Linux
# Figma is not natively available on Linux. Use the web version or AppImage.
wget https://github.com/Figma-Linux/figma-linux/releases/download/v0.9.3/Figma-linux_x86_64.AppImage -O figma.AppImage
chmod +x figma.AppImage
sudo mv figma.AppImage /usr/local/bin/figma
# Windows
choco install figma -y
scoop install extras/figma
winget install -e --id Figma.Figma
```

## GIMP

```bash
# Darwin
brew install --cask gimp
# Linux
sudo apt install -y gimp
# Windows
choco install gimp -y
scoop install extras/gimp
winget install -e --id GIMP.GIMP
```

## Inkscape

```bash
# Darwin
brew install --cask inkscape
# Linux
sudo apt install -y inkscape
# Windows
choco install inkscape -y
scoop install extras/inkscape
winget install -e --id Inkscape.Inkscape
```

## Sketch

```bash
# Darwin
brew install --cask sketch
# Linux
# Not available on Linux.
# Windows
# Not available on Windows.
```
