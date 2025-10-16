param(
    [Parameter(Mandatory=$false)]
    [string]$Package = "",

    [Parameter(Mandatory=$false)]
    [switch]$Force
)

$packageMap = $Package;
$installSuccess = $false;

# Parse the package string into a structured format
$packages = @();
if ($packageMap) {
    $packageMap -split ";" | ForEach-Object {
        $mapping = $_.Trim();
        if ($mapping) {
            if ($mapping -match "([^:]+):(.+)") {
                $packages += @{
                    Manager = $matches[1];
                    Package = $matches[2];
                }
            } else {
                # Default without manager prefix: try all in default order
                $packages += @{
                    Manager = "";
                    Package = $mapping;
                }
            }
        }
    }
}

# If no specific manager is specified, add default empty entry
if ($packages.Count -eq 0 -or ($packages.Count -eq 1 -and $packages[0].Manager -eq "")) {
    $packName = if ($packages.Count -eq 1) { $packages[0].Package } else { "" }
    $packages = @(
        @{ Manager = "winget"; Package = $packName },
        @{ Manager = "choco"; Package = $packName },
        @{ Manager = "scoop"; Package = $packName }
    )
}
$installCommands = @{
    "winget" = @{
        install = { param($pkg) winget install -e --id $pkg --silent --accept-package-agreements --uninstall-previous };
        forceInstall = { param($pkg) winget install -e --id $pkg --silent --accept-package-agreements --uninstall-previous --force };
    };
    "choco" = @{
        install = { param($pkg) choco install -y $pkg };
        forceInstall = { param($pkg) choco install -y $pkg --force };
    };
    "scoop" = @{
        install = { param($pkg)
            $items = $pkg -split "/";
            $bucket = if ($items.Length -gt 1) { $items[0] } else { "main" };
            scoop bucket add $bucket;
            scoop install $pkg;
        };
        forceInstall = { param($pkg)
            $items = $pkg -split "/";
            $bucket = if ($items.Length -gt 1) { $items[0] } else { "main" };
            scoop bucket add $bucket;
            scoop install $pkg -f;
        };
    };
};

# Try each package manager in order until one succeeds
foreach ($packageInfo in $packages) {
    $manager = $packageInfo.Manager;
    $package = $packageInfo.Package;

    # Skip empty packages
    if (-not $package) {
        continue;
    }

    # Skip if the manager doesn't exist or isn't supported
    if (-not $installCommands.ContainsKey($manager)) {
        Write-Host "Package manager $manager not found or not supported. Moving to next option." -ForegroundColor Yellow;
        continue;
    }

    # Skip if the command isn't available
    if (-not (Get-Command $manager -ErrorAction SilentlyContinue)) {
        Write-Host "Package manager $manager not installed. Moving to next option." -ForegroundColor Yellow;
        continue;
    }    $cmd = $installCommands[$manager];    # Try to install the package
    try {
        # Use force if specified
        if ($Force) {
            Write-Host "Attempting to force install $package using $manager..." -ForegroundColor Blue;
            & $cmd.forceInstall $package;
        } else {
            Write-Host "Attempting to install $package using $manager..." -ForegroundColor Blue;
            & $cmd.install $package;
        }

        # Check if installation was successful
        if ($LASTEXITCODE -eq 0 -or $null -eq $LASTEXITCODE) {
            $action = if ($Force) { "force installed" } else { "installed" }
            Write-Host "Successfully $action $package using $manager." -ForegroundColor Green;
            $installSuccess = $true;
            break;
        } else {
            Write-Host "Failed to install $package using $manager. Exit code: $LASTEXITCODE" -ForegroundColor Red;
        }
    } catch {
        Write-Host "Error installing $package using $manager`: $($_.Exception.Message)" -ForegroundColor Red;
    }
}

# Check if any installation succeeded
if (-not $installSuccess) {
    Write-Host "Failed to install $Package using any available package manager." -ForegroundColor Red;
    exit 1;
}
