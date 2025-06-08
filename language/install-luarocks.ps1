
# Installs LuaRocks on Windows (assumes Lua is already installed and in PATH)
# Reference: https://github.com/luarocks/luarocks/blob/main/docs/installation_instructions_for_windows.md


param(
    [string]$LuarocksVersion = "3.11.1",
    [string]$InstallDir = "C:\\ProgramData\\luarocks"
)

$ErrorActionPreference = 'Stop'

# Download LuaRocks
$zip = "luarocks-$LuarocksVersion-windows-64.zip"
$url = "https://luarocks.github.io/luarocks/releases/$zip"
$zipPath = "$env:TEMP\$zip"


if (!(Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
}


if (!(Test-Path "$InstallDir\luarocks.exe")) {
    Write-Host "Downloading LuaRocks $LuarocksVersion..."
    Invoke-WebRequest -Uri $url -OutFile $zipPath -UseBasicParsing
    Write-Host "Extracting LuaRocks..."
    Expand-Archive -Path $zipPath -DestinationPath $InstallDir -Force
    Remove-Item $zipPath
    Write-Host "LuaRocks $LuarocksVersion installed at $InstallDir"
} else {
    Write-Host "LuaRocks $LuarocksVersion already installed at $InstallDir"
}

# Update system PATH if not already present
$currentPath = [Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
if ($currentPath -notlike "*$InstallDir*") {
    Write-Host "Adding $InstallDir to system PATH..."
    [Environment]::SetEnvironmentVariable("Path", "$currentPath;$InstallDir", [System.EnvironmentVariableTarget]::Machine)
    Write-Host "PATH updated. You may need to restart your terminal or log out/in for changes to take effect."
} else {
    Write-Host "$InstallDir is already in the system PATH."
}

Write-Host "You can now use luarocks from PowerShell or CMD."
