# IM Tools

- [IM Tools](#im-tools)
  - [Default](#default)
  - [Discord](#discord)
  - [Ferdium](#ferdium)
  - [Slack](#slack)
  - [Rocket.Chat](#rocketchat)
  - [Teams](#teams)

## Default

```bash
# Darwin
brew install --cask discord ferdium slack

# Linux
sudo snap install discord ferdium slack --classic
# or using apt for Slack
sudo apt update && sudo apt install -y slack-desktop

# Windows
choco install discord ferdium slack -y

scoop bucket add extras && scoop install extras/discord extras/ferdium extras/slack

@("Discord.Discord", "Ferdium.Ferdium", "SlackTechnologies.Slack") | ForEach-Object { winget install -e --id $_ }
```

## Discord

```bash
# Darwin
brew install --cask discord
# Linux
sudo snap install discord
# Windows
choco install discord -y
scoop install extras/discord
winget install -e --id Discord.Discord
```

## Ferdium

```bash
# Darwin
brew install --cask ferdium
# Linux
sudo snap install ferdium --classic
# Windows
choco install ferdium -y
scoop install extras/ferdium
winget install -e --id Ferdium.Ferdium
```

## Slack

```bash
# Darwin
brew install --cask slack
# Linux
sudo snap install slack --classic
# or using apt
sudo apt update && sudo apt install -y slack-desktop
# Windows
choco install slack -y
scoop install extras/slack
winget install -e --id SlackTechnologies.Slack
```

## Rocket.Chat

```bash
# Darwin
brew install --cask rocket-chat
# Linux
sudo snap install rocketchat
# Windows
choco install rocketchat -y
scoop install extras/rocketchat-client
winget install -e --id RocketChat.RocketChat
```

## Teams

```bash
# Darwin
brew install --cask microsoft-teams
# Linux
sudo snap install teams
# or using apt
sudo apt update && sudo apt install -y teams
# Windows
choco install microsoft-teams -y
scoop install extras/microsoft-teams
winget install -e --id Microsoft.Teams
```
