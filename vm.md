# Virtual Machines & Containers

- [Virtual Machines & Containers](#virtual-machines--containers)
  - [Default](#default)
  - [Docker](#docker)
  - [Podman](#podman)
  - [QEMU](#qemu)
  - [Vagrant](#vagrant)
  - [VirtualBox](#virtualbox)

## Default

```bash
# Darwin
brew install podman docker docker-completion docker-compose qemu virtualbox

# Linux
sudo apt update && sudo apt install -y docker.io docker-compose podman qemu qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtualbox
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
sudo usermod -aG libvirt $USER

# Windows
choco install podman docker docker-compose qemu virtualbox -y

scoop bucket add main && scoop install main/podman main/docker main/qemu main/virtualbox

@("RedHat.Podman", "Docker.DockerDesktop", "SoftwareFreedomConservancy.QEMU", "Oracle.VirtualBox") | ForEach-Object { winget install -e --id $_ }
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

## Podman

```bash
# Darwin
brew install podman
# Linux
sudo apt install -y podman
# Windows
choco install podman -y
scoop install podman
winget install -e --id RedHat.Podman
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
