# REST Tools

- [REST Tools](#rest-tools)
  - [Default](#default)
  - [Insomnia](#insomnia)
  - [Postman](#postman)

## Default

```bash
# Darwin
brew install insomnia postman

# Linux
sudo snap install insomnia postman --classic

# Windows
choco install insomnia postman -y

scoop bucket add extras && scoop install extras/insomnia extras/postman

@("Insomnia.Insomnia", "Postman.Postman") | ForEach-Object { winget install -e --id $_ }
```

## Insomnia

```bash
# Darwin
brew install insomnia
# Linux
sudo snap install insomnia --classic
# Windows
choco install insomnia -y
scoop install extras/insomnia
winget install -e --id Insomnia.Insomnia
```

## Postman

```bash
# Darwin
brew install postman
# Linux
sudo snap install postman --classic
# Windows
choco install postman -y
scoop install extras/postman
winget install -e --id Postman.Postman
```
