# Git Tools

- [Git Tools](#git-tools)
  - [Default](#default)
  - [Git](#git)
  - [GitKraken](#gitkraken)
  - [GitHub CLI](#github-cli)
  - [LazyGit](#lazygit)

## Default

```bash
# Darwin
brew install git gitkraken gh

# Linux
sudo apt update && sudo apt install -y git gh
sudo snap install gitkraken --classic

# Windows
choco install git gitkraken gh -y

scoop install main/git extras/gitkraken main/gh

@("Git.Git", "Axosoft.GitKraken", "GitHub.cli") | ForEach-Object { winget install -e --id $_ }
```

## Git

```bash
# Darwin
brew install git
# Linux
sudo apt install git
# Windows
choco install git -y
scoop install git
winget install -e --id Git.Git
```

## GitKraken

```bash
# Darwin
brew install --cask gitkraken
# Linux
sudo snap install gitkraken --classic
# Windows
choco install gitkraken -y
scoop install extras/gitkraken
winget install -e --id Axosoft.GitKraken
```

## GitHub CLI

```bash
# Darwin
brew install gh
# Linux
sudo apt install gh
# Windows
choco install gh -y
scoop install gh
winget install -e --id GitHub.cli
```

## LazyGit

```bash
# Darwin
brew install lazygit
# Linux
sudo snap install lazygit --classic
# Windows
choco install lazygit -y
scoop install extras/lazygit
winget install -e --id JesseDuffield.lazygit
```
