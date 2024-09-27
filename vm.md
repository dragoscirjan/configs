# Virtual Machines & Containers

- [Virtual Machines & Containers](#virtual-machines--containers)
  - [Default](#default)
  - [Docker](#docker)
  - [QEMU](#qemu)
  - [Vagrant](#vagrant)
  - [VirtualBox](#virtualbox)

## Default

```bash
# Darwin
brew install docker docker-completion docker-compose qemu vagrant virtualbox

# Linux
sudo apt update && sudo apt install -y docker.io docker-compose qemu qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils vagrant virtualbox
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# Windows
choco install docker docker-compose qemu vagrant virtualbox -y

scoop bucket add main && scoop install main/docker main/qemu main/vagrant main/virtualbox

@("Docker.DockerDesktop", "SoftwareFreedomConservancy.QEMU", "Hashicorp.Vagrant", "Oracle.VirtualBox") | ForEach-Object { winget install -e --id $_ }
```

## Docker

```bash
# Darwin
brew install docker docker-completion docker-compose
# Linux
sudo apt install -y docker.io docker-compose
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
# Windows
choco install docker docker-compose -y
scoop install docker
winget install -e --id Docker.DockerDesktop
```

## QEMU

```bash
# Darwin
brew install qemu
# Linux
sudo apt install -y qemu qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
sudo usermod -aG libvirt $USER
# Windows
choco install qemu -y
scoop install qemu
winget install -e --id SoftwareFreedomConservancy.QEMU
```

## Vagrant

```bash
# Darwin
brew install vagrant
# Linux
sudo apt install -y vagrant
# Windows
choco install vagrant -y
scoop install vagrant
winget install -e --id Hashicorp.Vagrant
```

## VirtualBox

```bash
# Darwin
brew install virtualbox
# Linux
sudo apt install -y virtualbox
# Windows
choco install virtualbox -y
scoop install virtualbox
winget install -e --id Oracle.VirtualBox
```
