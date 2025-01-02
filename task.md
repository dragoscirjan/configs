# Virtual Machines & Containers

- [Virtual Machines \& Containers](#virtual-machines--containers)
  - [Default](#default)
  - [CMake](#cmake)
  - [Makefile](#makefile)
  - [Taskfile](#taskfile)
  - [XMake](#xmake)

## Default

```bash
# Darwin
brew install make go-task

# Linux
sudo apt install -y make
sudo sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /bin

# Windows
choco install make task -y

scoop bucket add main && scoop install main/make main/task

@("RedHat.Podman", "GnuWin32.Make", "Task.Task") | ForEach-Object { winget install -e --id $_ }
```

## CMake

```bash
# Darwin
brew install cmake
# Linux
sudo apt install -y cmake
# Windows
choco install cmake
scoop bucket add main; scoop install main/cmake
winget install -e --id Kitware.CMake
```

## Makefile

```bash
# Darwin
brew install make
# Linux
sudo apt install -y make
# Windows
choco install make
scoop bucket add main; scoop install main/make
winget install -e --id GnuWin32.Make
```

## Taskfile

```bash
# Darwin
brew install go-task
# Linux
sudo sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /bin
# Windows
choco install go-task
scoop bucket add main; scoop install main/task
winget install Task.Task
```

## XMake


```bash
# Darwin
brew install xmake
# Linux
curl -fsSL https://xmake.io/shget.text | bash
# Windows
Invoke-Expression (Invoke-Webrequest 'https://xmake.io/psget.text' -UseBasicParsing).Content
```
