# Usage: .\install-fonts-windows.ps1 <font-url1> <font-url2> ...


param (
    [Parameter(Mandatory=$true)]
    [string[]]$urls,
    [switch]$SystemWide
)


# Determine install directory
if ($SystemWide) {
    $fontDir = "C:\\Windows\\Fonts"
} else {
    $fontDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
}

# Elevate if system-wide and not admin
function Test-Admin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}
if ($SystemWide -and -not (Test-Admin)) {
    Write-Host "Restarting script as administrator for system-wide font installation..."
    $argList = @()
    $argList += '-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', ("'" + $MyInvocation.MyCommand.Definition + "'")
    $argList += '-urls'; $argList += $urls
    $argList += '-SystemWide'
    Start-Process powershell -Verb runAs -ArgumentList $argList
    exit
}

# Create the directory if it doesn't exist
if (-Not (Test-Path $fontDir)) {
    New-Item -ItemType Directory -Path $fontDir | Out-Null
}


# Download, extract, and install each font
foreach ($url in $urls) {
    Write-Host "Downloading font from $url ..."
    $fontZip = "$env:TEMP\font.zip"
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $url -OutFile $fontZip
    $ProgressPreference = 'Continue'

    $extractDir = "$env:TEMP\font_extract"
    if (Test-Path $extractDir) { Remove-Item $extractDir -Recurse -Force }
    Expand-Archive -Path $fontZip -DestinationPath $extractDir -Force
    Remove-Item $fontZip

    # Find all .ttf and .otf files in all subfolders
    $fontFiles = Get-ChildItem -Path $extractDir -Recurse -Include *.ttf,*.otf
    foreach ($fontFile in $fontFiles) {
        $destPath = Join-Path $fontDir $fontFile.Name
        Copy-Item $fontFile.FullName $destPath -Force

        if (Test-Path $destPath) {
            Write-Host "[OK] Installed: $($fontFile.Name)"
            if ($SystemWide) {
                # Register font in registry (system-wide)
                $regPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts'
                $fontName = $fontFile.BaseName
                $fontExt = $fontFile.Extension.ToLower()
                if ($fontExt -eq '.ttf') {
                    $regValue = "$fontName (TrueType)"
                } elseif ($fontExt -eq '.otf') {
                    $regValue = "$fontName (OpenType)"
                } else {
                    $regValue = $fontFile.Name
                }
                Set-ItemProperty -Path $regPath -Name $regValue -Value $fontFile.Name -Force
            }
        } else {
            Write-Host "[ERROR] Failed to install: $($fontFile.Name)" -ForegroundColor Red
        }
    }
    Remove-Item $extractDir -Recurse -Force
}

# Windows 11/10: Font cache refresh is not required; fonts are available after copy.
if ($SystemWide) {
    Write-Host "All fonts installed system-wide! If you don't see the new fonts, log out and log back in, or open the Fonts control panel to trigger a refresh."
} else {
    Write-Host "All fonts installed for the current user! If you don't see the new fonts, log out and log back in, or open the Fonts control panel to trigger a refresh."
}
