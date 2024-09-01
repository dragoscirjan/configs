# Virtualization

- [IDEs](#ides)
  - [Default](#default)
  - [CLion](#clion)
  - [Fleet](#fleet)
  - [Goland](#goland)
  - [IntelliJ IDEA](#intellij-idea)
  - [IntelliJ IDEA Community Edition](#intellij-idea-community-edition)
  - [Neovim](#neovim)
    - [LazyVim](#lazyvim)
        - [LazyVim Config](#lazyvim-config)
  - [PhpStorm](#phpstorm)

## Default

```bash
# Darwin
brew install \
  docker docker-completion docker-compose \
  qemu \
  vagrant \
  virtualbox
```

```bash
# Linux
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh \
  && sudo sh /tmp/get-docker.sh --dry-run \
  && sudo sh /tmp/get-docker.sh \
  \
  && wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list \
  && sudo apt update \
  && sudo apt install \
    qemu-system \
    vagrant \
    virtualbox virtualbox-ext-pack \
    -y
```

```powershell
# Windows
choco install `
  docker-desktop `
  qemu `
  vagrant `
  virtualbox -y
```

## Docker

```bash
# Darwin
brew install docker docker-completion docker-compose
# Linux
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh && sudo sh /tmp/get-docker.sh --dry-run
# Windows
choco install docker-desktop -y
scoop bucket add extras && scoop install extras/clion
winget install -e --id Docker.DockerDesktop
```

## QEmu

```bash
# Darwin
brew install qemu
```

```bash
# Linux
# Ubuntu
sudo apt-get install qemu-system -y
# Fedora
dnf install @virtualization
# From source code
# https://www.qemu.org/download/#source
```

```powershell
# Windows
choco install qemu -y
scoop bucket add main && scoop install main/qemu
winget install -e --id SoftwareFreedomConservancy.QEMU
```

## Vagrant

```bash
# Darwin => https://developer.hashicorp.com/vagrant/downloads#darwin
brew tap hashicorp/tap
brew install hashicorp/tap/hashicorp-vagrant
```

```bash
# Linux => https://developer.hashicorp.com/vagrant/downloads#linux
# Fedora
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf -y install vagrant
# Ubuntu
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant
```

```powershell
# Windows
choco install vagrant -y
scoop bucket add main && scoop install main/vagrant
winget install -e --id Hashicorp.Vagrant
```

## Virtualbox

```bash
# Darwin
brew install virtualbox
# Linux
sudo apt install virtualbox virtualbox-ext-pack -y
# Windows
choco install virtualbox -y
scoop bucket add nonportable && scoop install nonportable/virtualbox-np
winget install -e --id Oracle.VirtualBox
```
