# Usage: .\install_fonts_windows.ps1 <font-url1> <font-url2> ...

param (
    [Parameter(Mandatory=$true)]
    [string[]]$urls
)

# Font installation directory
$fontDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"

# Create the directory if it doesn't exist
if (-Not (Test-Path $fontDir)) {
    New-Item -ItemType Directory -Path $fontDir
}

# Download and install each font
foreach ($url in $urls) {
    Write-Host "Downloading font from $url ..."
    $fontZip = "$env:TEMP\font.zip"
    Invoke-WebRequest -Uri $url -OutFile $fontZip

    Write-Host "Installing font from $url ..."
    Expand-Archive -Path $fontZip -DestinationPath $fontDir -Force
    Remove-Item $fontZip
}

# Refresh font cache
Write-Host "Refreshing font cache..."
Add-Type -AssemblyName PresentationCore
$shellApp = New-Object -ComObject Shell.Application
$shellApp.Namespace(0x14).ParseName('Fonts').InvokeVerb('Install')

Write-Host "All fonts installed successfully!"
