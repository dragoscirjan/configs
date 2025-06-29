# Installs Go on Windows following https://go.dev/doc/install
# Downloads the specified Go MSI and installs it system-wide

param(
    [string]$GoVersion = "1.22.4"  # Update to latest if needed
)

$ErrorActionPreference = 'Stop'

# Determine architecture and construct download URL
$arch = if ([Environment]::Is64BitOperatingSystem) { "amd64" } else { "386" }
$goMsiName = "go$GoVersion.windows-$arch.msi"
$goMsiUrl = "https://go.dev/dl/$goMsiName"
$goMsiPath = "$env:TEMP\$goMsiName"

# Download Go MSI silently
Write-Host "Downloading Go $GoVersion..."
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $goMsiUrl -OutFile $goMsiPath -UseBasicParsing
$ProgressPreference = 'Continue'

# Run Go installer silently
Write-Host "Running Go installer..."
Start-Process msiexec.exe -Wait -ArgumentList "/i `"$goMsiPath`" /qn"

# Remove installer file
Remove-Item $goMsiPath -Force

Write-Host "Go $GoVersion installed. Run 'go version' to verify."
