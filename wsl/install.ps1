
param(
    [Parameter(Mandatory=$true)]
    [string]$Package,

    [Parameter(Mandatory=$false)]
    [string]$Url
)

$ErrorActionPreference = 'Continue'

Write-Host "Installing WSL distribution: $Package"

# Try to install from Microsoft Store first
Write-Host "Attempting to install $Package from Microsoft Store..."
wsl --install -d $Package

if ($LASTEXITCODE -eq 0) {
    Write-Host "Successfully installed $Package via WSL store" -ForegroundColor Green
} else {
    Write-Host "WSL store installation failed (exit code: $LASTEXITCODE)" -ForegroundColor Yellow

    if ($Url) {
        Write-Host "Trying to import from URL: $Url" -ForegroundColor Cyan

        # Create import directory
        $importPath = "$env:USERPROFILE\WSL\$Package"
        New-Item -ItemType Directory -Force -Path $importPath | Out-Null

        # Download and import
        $tempFile = "$env:TEMP\$Package-rootfs.tar.gz"
        try {
            Write-Host "Downloading rootfs..."
            Invoke-WebRequest -Uri $Url -OutFile $tempFile -UseBasicParsing

            Write-Host "Importing $Package..."
            wsl --import $Package $importPath $tempFile

            if ($LASTEXITCODE -eq 0) {
                Write-Host "Successfully imported $Package from $Url" -ForegroundColor Green
                Remove-Item $tempFile -Force -ErrorAction SilentlyContinue
            } else {
                Write-Error "Failed to import $Package (exit code: $LASTEXITCODE)"
                exit 1
            }
        } catch {
            Write-Error "Failed to download or import $Package from $Url`: $_"
            Remove-Item $tempFile -Force -ErrorAction SilentlyContinue
            exit 1
        }
    } else {
        Write-Error "Installation failed and no URL provided for fallback import"
        exit 1
    }
}
