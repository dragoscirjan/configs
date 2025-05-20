# IDEs

- [IDEs](#ides)
  - [Default](#default)
  - [Coursor](#coursor)
  - [Trae](#trae)

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

## Coursor

```bash
# Darwin
brew install coursor
# Linux
sudo snap install coursor --classic
# Windows
choco install coursor -y
scoop bucket add extras && scoop install extras/coursor
winget install -e --id Coursor.Coursor
```

## Trae

```bash
# Darwin
brew install trae
# Linux
sudo snap install trae --classic
# Windows
choco install trae -y
scoop bucket add extras && scoop install extras/trae
winget install -e --id Trae.Trae
```

