#
# Install Chocolatey
#
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#
# Install make
#
choco install make

#
# Install Git
#
