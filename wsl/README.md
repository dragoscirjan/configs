# WSL Linux Distributions

- [WSL Linux Distributions](#wsl-linux-distributions)
  - [Overview](#overview)
  - [Installation](#installation)
    - [Minimal Requirements](#minimal-requirements)
    - [Available Distributions](#available-distributions)
      - [Alpine](#alpine)
      - [Ubuntu](#ubuntu)
      - [Fedora](#fedora)
      - [Arch](#arch)
      - [NixOS](#nixos)
  - [Attaching to a Distribution](#attaching-to-a-distribution)
  - [Taskfile Usage](#taskfile-usage)

## Overview

This folder provides Taskfile tasks to automate the installation and management of various Linux distributions under Windows Subsystem for Linux (WSL). You can quickly install or attach to Alpine, Ubuntu, Fedora, Arch, or NixOS using simple commands.

## Installation

### Minimal Requirements

- Windows 10/11 with WSL enabled
- [Task](https://taskfile.dev/) installed for task automation

### Available Distributions

#### Alpine
```sh
# Install Alpine Linux (WSL)
task alpine
```

#### Ubuntu
```sh
# Install Ubuntu (WSL)
task ubuntu
```

#### Fedora
```sh
# Install Fedora (WSL)
task fedora
```

#### Arch
```sh
# Install Arch Linux (WSL, unofficial)
task arch
```

#### NixOS
```sh
# Install NixOS (WSL, unofficial)
task nixos
```

## Attaching to a Distribution

After installation, you can open a shell in any installed distribution:

```sh
# Attach to Alpine
task alpine:attach

# Attach to Ubuntu
task ubuntu:attach

# Attach to Fedora
task fedora:attach

# Attach to Arch
task arch:attach

# Attach to NixOS
task nixos:attach
```

## Taskfile Usage

- All install and attach commands are defined in the `Taskfile.yml` in this folder.
- Use `task --list` to see all available tasks.
- The install tasks will attempt to use the official WSL images or import from upstream sources if not available.

---

For more details on WSL, see the [Microsoft WSL documentation](https://docs.microsoft.com/en-us/windows/wsl/).
