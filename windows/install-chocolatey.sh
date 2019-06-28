#! /bin/bash

#
# @see https://chocolatey.org/install#installing-chocolatey
#
which choco > /dev/null \
	|| cat | powershell <<EOF
#Requires -RunAsAdministrator
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
EOF