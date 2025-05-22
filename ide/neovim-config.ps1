#!/usr/bin/env pwsh
#
# Script to link the neovim-config folder to ~/AppData/Local/nvim.
#
# Usage:
#   neovim-config.ps1              # Install neovim config and set up Git safe.directory
#   neovim-config.ps1 -FixGitOnly  # Only fix Git "dubious ownership" issues

param(
    [switch]$FixGitOnly = $false
)

# Ensure the script stops on errors
$ErrorActionPreference = 'Stop'

# Function to add Neovim plugin directories to Git safe.directory
function Add-NeovimPluginsToGitSafeDirectory {
    param(
        [string]$ConfigPath
    )

    Write-Host "Adding Neovim directories to Git safe.directory configuration..."

    # Get Neovim config and data directories
    $nvimConfigPath = Join-Path -Path $env:LOCALAPPDATA -ChildPath "nvim"
    $nvimDataPath = Join-Path -Path $env:LOCALAPPDATA -ChildPath "nvim-data"

    # Add main config directory if it exists
    if (Test-Path -Path $nvimConfigPath -PathType Container) {
        Write-Host "Adding Neovim config directory to Git safe.directory: $nvimConfigPath"
        git config --global --add safe.directory $nvimConfigPath

        # Check if it's a symlink and get the target
        $item = Get-Item $nvimConfigPath -ErrorAction SilentlyContinue
        if ($item -and $item.LinkType -eq "SymbolicLink") {
            $targetPath = $item.Target
            Write-Host "Neovim config is a symlink pointing to $targetPath"
            git config --global --add safe.directory $targetPath
        }
    }

    # Add the specified config path if provided
    if ($ConfigPath -and ($ConfigPath -ne $nvimConfigPath)) {
        Write-Host "Adding specified config directory to Git safe.directory: $ConfigPath"
        git config --global --add safe.directory $ConfigPath
    }

    # Add plugin directories
    $pluginDirs = @(
        # LazyVim plugins directory
        (Join-Path -Path $nvimDataPath -ChildPath "lazy")
    )

    foreach ($dir in $pluginDirs) {
        if (Test-Path -Path $dir -PathType Container) {
            Write-Host "Adding Neovim plugin directory to Git safe.directory: $dir"
            git config --global --add safe.directory $dir

            # Add individual plugin repositories
            Get-ChildItem -Path $dir -Directory | ForEach-Object {
                if (Test-Path -Path (Join-Path -Path $_.FullName -ChildPath ".git") -PathType Container) {
                    Write-Host "Adding plugin repository to Git safe.directory: $($_.FullName)"
                    git config --global --add safe.directory $_.FullName
                }
            }
        }
    }

    # Create a local .gitconfig file in the neovim-config directory
    $neovimConfigSource = $null

    # Check if nvim is a symlink and find the source
    if (Test-Path -Path $nvimConfigPath -PathType Container) {
        $item = Get-Item $nvimConfigPath -ErrorAction SilentlyContinue
        if ($item -and $item.LinkType -eq "SymbolicLink") {
            $neovimConfigSource = $item.Target
        }
    }

    # If we found the source directory, create a .gitconfig file there
    if ($neovimConfigSource -and (Test-Path -Path $neovimConfigSource -PathType Container)) {
        $gitConfigPath = Join-Path -Path $neovimConfigSource -ChildPath ".gitconfig"

        Write-Host "Creating local .gitconfig file at: $gitConfigPath"

        # Create the file if it doesn't exist or append to it
        if (-not (Test-Path -Path $gitConfigPath)) {
            @"
[safe]
	directory = $($nvimConfigPath.Replace("\", "/"))
	directory = $($neovimConfigSource.Replace("\", "/"))
	directory = $($nvimDataPath.Replace("\", "/"))/lazy
"@ | Out-File -FilePath $gitConfigPath -Encoding utf8
        }

        # Add plugin directories
        foreach ($dir in $pluginDirs) {
            if (Test-Path -Path $dir -PathType Container) {
                # Get all plugin directories
                Get-ChildItem -Path $dir -Directory | ForEach-Object {
                    if (Test-Path -Path (Join-Path -Path $_.FullName -ChildPath ".git") -PathType Container) {
                        $pluginPath = $_.FullName.Replace("\", "/")

                        # Check if already in config
                        $configContent = Get-Content -Path $gitConfigPath -Raw
                        if (-not $configContent.Contains("directory = $pluginPath")) {
                            Add-Content -Path $gitConfigPath -Value "`tdirectory = $pluginPath"
                        }
                    }
                }
            }
        }

        Write-Host "Local .gitconfig file updated at $gitConfigPath"
    }

    Write-Host "Git safe.directory configuration complete!"
}

# Main function to setup neovim configuration
function Main {
    # Get the directory where this script is located
    $SCRIPT_DIR = $PSScriptRoot
    if (-not $SCRIPT_DIR) {
        # Fallback method if $PSScriptRoot is not available
        $SCRIPT_DIR = Split-Path -Parent (Resolve-Path $MyInvocation.MyCommand.Definition -ErrorAction SilentlyContinue)

        # If that also fails, use the current directory
        if (-not $SCRIPT_DIR) {
            $SCRIPT_DIR = (Get-Location).Path
            Write-Warning "Could not determine script directory, using current directory: $SCRIPT_DIR"
        }
    }

    $CONFIG_SOURCE = Join-Path -Path $SCRIPT_DIR -ChildPath "neovim-config"

    # If FixGitOnly is specified, just fix Git ownership issues and exit
    if ($FixGitOnly) {
        if (-not (Test-Path -Path $CONFIG_SOURCE -PathType Container)) {
            Write-Error "ERROR: Source directory $CONFIG_SOURCE does not exist."
            exit 1
        }

        Write-Host "Running Git safe.directory fix for Neovim plugins..."
        Add-NeovimPluginsToGitSafeDirectory -ConfigPath $CONFIG_SOURCE
        return 0
    }

    $CONFIG_TARGET = Join-Path -Path $env:LOCALAPPDATA -ChildPath "nvim"

    # Verify source directory exists
    if (-not (Test-Path -Path $CONFIG_SOURCE -PathType Container)) {
        Write-Error "ERROR: Source directory $CONFIG_SOURCE does not exist."
        exit 1
    }

    # Backup existing nvim config if it exists
    $configExists = Test-Path -Path $CONFIG_TARGET -PathType Container
    $isSymlink = $false

    if (Test-Path -Path $CONFIG_TARGET -ErrorAction SilentlyContinue) {
        $item = Get-Item $CONFIG_TARGET -ErrorAction SilentlyContinue
        if ($item -and $item.LinkType -eq "SymbolicLink") {
            $isSymlink = $true
        }
    }

    if ($configExists -or $isSymlink) {
        $TIMESTAMP = Get-Date -Format "yyyyMMddHHmmss"
        $BACKUP_NAME = "$env:LOCALAPPDATA\nvim.bak.$TIMESTAMP"
        $BACKUP_ZIP = "$env:LOCALAPPDATA\nvim.bak.$TIMESTAMP.zip"

        Write-Host "Backing up existing nvim config to $BACKUP_NAME"
        if (Test-Path -Path $CONFIG_TARGET -PathType Container) {
            # It's a directory, move it
            Move-Item -Path $CONFIG_TARGET -Destination $BACKUP_NAME
        } else {
            # It might be a symlink
            $linkTarget = (Get-Item $CONFIG_TARGET).Target
            Remove-Item -Path $CONFIG_TARGET -Force
            if ($linkTarget -and (Test-Path -Path $linkTarget -PathType Container)) {
                Copy-Item -Path $linkTarget -Destination $BACKUP_NAME -Recurse
            }
        }

        Write-Host "Creating zip archive of backup at $BACKUP_ZIP"
        try {
            Compress-Archive -Path $BACKUP_NAME -DestinationPath $BACKUP_ZIP
            Write-Host "Removing backup folder"
            Remove-Item -Path $BACKUP_NAME -Recurse -Force
            Write-Host "Backup saved to $BACKUP_ZIP"
        } catch {
            Write-Error "ERROR: Failed to create backup zip. Original backup folder preserved at $BACKUP_NAME"
            exit 1
        }
    }

    # Create the symlink
    Write-Host "Linking $CONFIG_SOURCE to $CONFIG_TARGET"

    # Create symbolic link using PowerShell or cmd based on availability and permissions
    try {
        # Try PowerShell command first (requires admin rights in most cases)
        New-Item -ItemType SymbolicLink -Path $CONFIG_TARGET -Target $CONFIG_SOURCE -Force
    } catch {
        try {
            # Fall back to mklink (may work in cases where PS command doesn't)
            cmd /c "mklink /D `"$CONFIG_TARGET`" `"$CONFIG_SOURCE`""
        } catch {
            # If both methods fail, try a simple copy
            Write-Warning "Unable to create symbolic link. Falling back to copying files."
            Copy-Item -Path $CONFIG_SOURCE -Destination $CONFIG_TARGET -Recurse -Force
        }    }

    # Fix Git "dubious ownership" errors for Neovim plugins
    Add-NeovimPluginsToGitSafeDirectory -ConfigPath $CONFIG_SOURCE

    Write-Host "NeoVim configuration setup complete!"
    Write-Host "Source: $CONFIG_SOURCE"
    Write-Host "Target: $CONFIG_TARGET"

    return 0
}

# Execute main function
Main
