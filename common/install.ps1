param(
    [Parameter(Mandatory=$false)]
    [string]$Package = "{{ .PACKAGE }}",

    [Parameter(Mandatory=$false)]
    [switch]$Force
)

$packageMap = $Package;
$manager = "";
$package = "";

("winget,choco,scoop" -split "," | ForEach-Object {
    if (-not $manager -or -not $package) {
        $manager = $_.Trim();

        if (-not (Get-Command $manager -ErrorAction SilentlyContinue)) {
            Write-Host "Package manager $manager not found. Moving on." -ForegroundColor Yellow;
            $manager = "";
        }

        if ($packageMap -match "${manager}:") {
            $packageMap -split ";" | ForEach-Object {
                $mapping = $_;
                if ($mapping -match "${manager}:") {
                    $package = $mapping.Replace("${manager}:", "");
                }
            }
        } else {
            $packageMap -split ";" | ForEach-Object {
                $mapping = $_;
                if (-not ($mapping -match ":")) {
                    $package = $mapping;
                }
            }
        }

        if ($package) {
            Write-Host "Using $manager package manager to install $package" -ForegroundColor Blue;
        }
    }
});
$installCommands = @{
    "winget" = @{
        check = { param($pkg) winget list | Select-String -Pattern $pkg };
        install = { param($pkg) winget install -e --id $pkg };
        forceInstall = { param($pkg) winget install -e --id $pkg --force };
    };
    "choco" = @{
        check = { param($pkg) choco list | Select-String -Pattern $pkg };
        install = { param($pkg) choco install -y $pkg };
        forceInstall = { param($pkg) choco install -y $pkg --force };
    };
    "scoop" = @{
        check = { param($pkg) scoop list | Select-String -Pattern $pkg };
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
if ($installCommands.ContainsKey($manager)) {
    $cmd = $installCommands[$manager];

    # Use Force parameter if provided, otherwise use the template variable
    $useForce = $Force -or "{{if .FORCE}}$true{{else}}$false{{end}}";

    if ($useForce) {
        Write-Host "Force installing $package using $manager" -ForegroundColor Blue;
        & $cmd.forceInstall $package;
    } else {
        if (-not (& $cmd.check $package)) {
            Write-Host "Installing $package using $manager" -ForegroundColor Blue;
            & $cmd.install $package;
        } else {
            Write-Host "$package already installed" -ForegroundColor Yellow;
        }
    }
}
