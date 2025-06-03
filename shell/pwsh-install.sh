#! /bin/bash

if command -v apk; then
  # https://learn.microsoft.com/en-us/powershell/scripting/install/install-alpine?view=powershell-7.5
  # install the requirements
  sudo apk add --no-cache \
      ca-certificates \
      less \
      ncurses-terminfo-base \
      krb5-libs \
      libgcc \
      libintl \
      libssl3 \
      libstdc++ \
      tzdata \
      userspace-rcu \
      zlib \
      icu-libs \
      curl
  apk -X https://dl-cdn.alpinelinux.org/alpine/edge/main add --no-cache \
      lttng-ust \
      openssh-client \
  # Download the powershell '.tar.gz' archive
  curl -L https://github.com/PowerShell/PowerShell/releases/download/v7.5.1/powershell-7.5.1-linux-musl-x64.tar.gz -o /tmp/powershell.tar.gz
  # Create the target folder where powershell will be placed
  sudo mkdir -p /opt/microsoft/powershell/7
  # Expand powershell to the target folder
  sudo tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7
  # Set execute permissions
  sudo chmod +x /opt/microsoft/powershell/7/pwsh
  # Create the symbolic link that points to pwsh
  sudo ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh

elif command -v apt; then
  # https://learn.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.5
  # Update the list of packages
  sudo apt-get update
  # Install pre-requisite packages.
  sudo apt-get install -y wget apt-transport-https software-properties-common
  # Get the version of Ubuntu
  source /etc/os-release
  # Download the Microsoft repository keys
  wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb
  # Register the Microsoft repository keys
  sudo dpkg -i packages-microsoft-prod.deb
  # Delete the Microsoft repository keys file
  rm packages-microsoft-prod.deb
  # Update the list of packages after we added packages.microsoft.com
  sudo apt-get update
  # Install PowerShell
  sudo apt-get install -y powershell
elif command -v dnf; then

  # https://learn.microsoft.com/en-us/powershell/scripting/install/install-rhel?view=powershell-7.5
  # Get version of RHEL
  source /etc/os-release
  if [ ${VERSION_ID%.*} -lt 8 ]; then majorver=7
  elif [ ${VERSION_ID%.*} -lt 9 ]; then majorver=8
  else majorver=9
  fi
  # Download the Microsoft RedHat repository package
  curl -sSL -O https://packages.microsoft.com/config/rhel/$majorver/packages-microsoft-prod.rpm
  # Register the Microsoft RedHat repository
  sudo rpm -i packages-microsoft-prod.rpm
  # Delete the downloaded package after installing
  rm packages-microsoft-prod.rpm
  # Update package index files
  sudo dnf update
  # Install PowerShell
  sudo dnf install powershell -y
else
  echo "Unsupported package manager. Please install PowerShell manually."
  exit 1
fi
