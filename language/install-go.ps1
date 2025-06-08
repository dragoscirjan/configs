# Installs Go on Windows following https://go.dev/doc/install
# Downloads the latest Go MSI and installs it system-wide

param(
    [string]$GoVersion = "1.22.4"  # Update to latest if needed
)

$ErrorActionPreference = 'Stop'

# Construct download URL
$arch = if ([Environment]::Is64BitOperatingSystem) { "amd64" } else { "386" }
$msi = "go$GoVersion.windows-$arch.msi"
$url = "https://go.dev/dl/$msi"
$msiPath = "$env:TEMP\$msi"


# Download Go silently (no progress bar)
Write-Host "Downloading Go $GoVersion..."
$ProgressPreference = 'SilentlyContinue'
Invoke-WebRequest -Uri $url -OutFile $msiPath -UseBasicParsing -ErrorAction SilentlyContinue | Out-Null
$ProgressPreference = 'Continue'

Write-Host "Running Go installer..."
Start-Process msiexec.exe -Wait -ArgumentList "/i `"$msiPath`" /qn"

Remove-Item $msiPath

Write-Host "Go $GoVersion installed. Run 'go version' to verify."
