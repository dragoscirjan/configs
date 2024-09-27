# Office Tools

- [Office Tools](#office-tools)
  - [Default](#default)
  - [LibreOffice](#libreoffice)
  - [Notion](#notion)
  - [OpenOffice](#openoffice)
  - [WPS Office](#wps-office)

## Default

```bash
# Darwin
brew install --cask wpsoffice notion

# Linux
sudo apt update && sudo apt install -y snapd
sudo snap install notion-snap-reborn wpsoffice-multilang

# Windows
choco install wpsoffice notion -y

scoop bucket add extras && scoop install extras/wpsoffice extras/notion

@("Kingsoft.WPSOffice", "Notion.Notion") | ForEach-Object { winget install -e --id $_ }
```

## LibreOffice

```bash
# Darwin
brew install libreoffice
# Linux
sudo apt install -y libreoffice
# or using snap
sudo snap install libreoffice
# Windows
choco install libreoffice -y
scoop install extras/libreoffice
winget install -e --id TheDocumentFoundation.LibreOffice
```

## Notion

```bash
# Darwin
brew install --cask notion
# Linux
sudo snap install notion-snap-reborn
# Windows
choco install notion -y
scoop install extras/notion
winget install -e --id Notion.Notion
```

## OpenOffice

```bash
# Darwin
brew install openoffice
# Linux
sudo apt install -y openoffice
# Windows
choco install openoffice -y
scoop install extras/openoffice
winget install -e --id Apache.OpenOffice
```

## WPS Office

```bash
# Darwin
brew install --cask wpsoffice
# Linux
sudo snap install wpsoffice-multilang
# Windows
choco install wps-office-free -y
scoop install extras/wpsoffice
winget install -e --id Kingsoft.WPSOffice
```
