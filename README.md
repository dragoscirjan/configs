# Tools Installation

This repository contains a collection of markdown files that provide instructions for installing various tools and applications across different categories using common package managers. The tools are grouped by category into markdown files, and each file includes installation commands for macOS, Linux, and Windows.

## List of Markdown Files

1. **[IDE Tools](ide.md)**: Covers IDEs such as Visual Studio Code, IntelliJ IDEA, CLion, PyCharm, and more.
2. **[Browser Tool](browser.md)s**: Covers popular web browsers like Chrome, Firefox, Brave, and more.
3. **[Git Tools](git.md)**: Covers Git tools such as Git, GitKraken, GitHub CLI, and LazyGit.
4. **[IM Tools](im.md)**: Covers instant messaging tools like Discord, Ferdium, Slack, and more.
5. **[Programming Languages](language.md)**: Covers installation for programming languages like Python, Rust, Go, Zig, and more.
6. **[SSL Tools](ssl.md)**: Covers SSL-related tools such as OpenSSL and LibreSSL.
7. **[Virtual Machines & Containers](vm.md)**: Covers VM and container tools like Docker, Podman, VirtualBox, and QEMU.
8. **[VPN Tools](vpn.md)**: Covers VPN tools like OpenVPN.
9. **[REST Tools](rest.md)**: Covers REST tools like Postman and Insomnia.
10. **[Office Tools](office.md)**: Covers office productivity tools like WPS Office, Notion, LibreOffice, and more.
11. **[Design Tools](design.md)**: Covers design tools like GIMP, Figma, Inkscape, and Sketch.
12. **[Terminal Tools](terminal.md)**: Covers terminal emulators like Alacritty, WezTerm, Ghostty, and more.

## Package Managers Used

### macOS

1. **Homebrew (`brew`)**: A package manager for macOS that allows you to install software directly from the command line.
   - [Homebrew Homepage](https://brew.sh/)
   - **Installation**:
     ```bash
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
     ```

### Linux

1. **APT (`apt`)**: A package manager used in Debian and Ubuntu-based distributions.
   - [APT Documentation](https://wiki.debian.org/Apt)
   - **Installation**: Usually pre-installed in Debian/Ubuntu systems.
2. **Snap**: A package manager developed by Canonical that works across a range of Linux distributions.
   - [Snapcraft Homepage](https://snapcraft.io/)
   - **Installation**:
     ```bash
     sudo apt update
     sudo apt install snapd
     ```
3. **YUM/DNF**: Used for RPM-based distributions like CentOS, Fedora, and RHEL.
   - [YUM Documentation](http://yum.baseurl.org/)
   - [DNF Documentation](https://dnf.readthedocs.io/)
   - **Installation**: Usually pre-installed in RPM-based systems.

### Windows

1. **Chocolatey (`choco`)**: A package manager for Windows that allows you to install software directly from the command line.
   - [Chocolatey Homepage](https://chocolatey.org/)
   - **Installation**:
     ```powershell
     Set-ExecutionPolicy Bypass -Scope Process -Force; 
     [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
     iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
     ```
2. **Scoop**: A command-line installer for Windows that makes installing and managing apps easier.
   - [Scoop Homepage](https://scoop.sh/)
   - **Installation**:
     ```powershell
     Set-ExecutionPolicy RemoteSigned -scope CurrentUser
     iwr -useb get.scoop.sh | iex
     ```
   - Adding Buckets:
     ```powershell
     scoop bucket add main
     scoop bucket add extras
     ```

3. **Winget**: The Windows Package Manager CLI, also known as `winget`.
   - [Winget Homepage](https://aka.ms/winget)
   - **Installation**: Usually pre-installed on Windows 10 and later versions. If not, you can download it from the [Microsoft Store](https://aka.ms/winget).

## How to Use

Each markdown file contains commands for installing the tools on different operating systems using the appropriate package manager. Simply follow the commands under each section to install the desired tools on your machine.

For example, to install Visual Studio Code on macOS using Homebrew:

```bash
brew install --cask visual-studio-code
```

For Windows using Chocolatey:

```powershell
choco install vscode -y
```

This structured approach helps in maintaining consistency and ease of installation across multiple environments.
