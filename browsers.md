# Browsers

- [Browsers](#browsers)
  - [Default](#default)
  - [Arc](#arc)
  - [Brave](#brave)
  - [Chrome](#chrome)
  - [Chromium](#chromium)
  - [Edge](#edge)
  - [Firefox](#firefox)
  - [Opera](#opera)
  - [Vivaldi](#vivaldi)

## Default

```bash
# Darwin
brew install --cask google-chrome firefox brave-browser

# Linux
sudo apt update && sudo apt install -y brave-browser firefox
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O google-chrome.deb && sudo apt install -y ./google-chrome.deb && rm -f google-chrome.deb
# or alternatively using snap
sudo snap install brave firefox chromium # Chrome is not available in snap

# Windows
choco install googlechrome firefox brave -y

scoop bucket add extras && scoop install extras/googlechrome extras/firefox extras/brave

@("Google.Chrome", "Mozilla.Firefox", "Brave.Brave") | ForEach-Object { winget install -e --id $_ }
```

## Arc

```bash
# Darwin
brew install --cask arc
# Linux
# Not available on Linux
# Windows
# Not available on Windows
```

## Brave

```bash
# Darwin
brew install --cask brave-browser
# Linux
sudo apt install brave-browser
# Windows
choco install brave -y
scoop install extras/brave
winget install -e --id Brave.Brave
```

## Chrome

```bash
# Darwin
brew install --cask google-chrome
# Linux
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O google-chrome.deb
sudo apt install -y ./google-chrome.deb
rm -f google-chrome.deb
# or using snap
# sudo snap install chromium # Google Chrome is not available on snap, but Chromium is an alternative.
# Windows
choco install googlechrome -y
scoop install extras/googlechrome
winget install -e --id Google.Chrome
```

## Chromium

```bash
# Darwin
brew install --cask chromium
# Linux
sudo apt install chromium-browser
# Windows
choco install chromium -y
scoop install extras/chromium
winget install -e --id Hibbiki.Chromium
```

## Edge

```bash
# Darwin
brew install --cask microsoft-edge
# Linux
wget https://packages.microsoft.com/repos/edge/pool/main/m/microsoft-edge-stable/microsoft-edge-stable_current_amd64.deb -O microsoft-edge.deb
sudo apt install -y ./microsoft-edge.deb
rm -f microsoft-edge.deb
# or using snap
# sudo snap install edge
# Windows
choco install microsoft-edge -y
winget install -e --id Microsoft.Edge
```

## Firefox

```bash
# Darwin
brew install --cask firefox
# Linux
sudo apt install -y firefox
# or using snap
sudo snap install firefox
# Windows
choco install firefox -y
scoop install extras/firefox
winget install -e --id Mozilla.Firefox
```

## Opera

```bash
# Darwin
brew install --cask opera
# Linux
sudo apt install opera-stable
# or using snap
sudo snap install opera
# Windows
choco install opera -y
scoop install extras/opera
winget install -e --id Opera.Opera
```

## Vivaldi

```bash
# Darwin
brew install --cask vivaldi
# Linux
sudo apt install vivaldi-stable
# Windows
choco install vivaldi -y
scoop install extras/vivaldi
winget install -e --id VivaldiTechnologies.Vivaldi
```
