param (
    [switch]$Browser,
    [string]$BrowserList,
    [switch]$Font,
    [string]$FontList,
    [switch]$Git,
    [string]$GitList,
    [switch]$Ide,
    [string]$IdeList,
    [switch]$Im,
    [string]$ImList,
    [switch]$Language,
    [string]$LanguageList,
    [switch]$Office,
    [string]$OfficeList,
    [switch]$Rest,
    [string]$RestList,
    [switch]$Ssl,
    [string]$SslList,
    [switch]$Vm,
    [string]$VmList,
    [switch]$Vpn,
    [string]$VpnList,

    [string]$PreferredInstallers,
    [switch]$Help,
    [switch]$H
)

if ($env:DEBUG) {
    $VerbosePreference = "Continue"
    $DebugPreference = "Continue"
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$scriptName = Split-Path -Leaf $MyInvocation.MyCommand.Definition
$scriptVersion = ""
$scriptAppsList = "./apps.json"
$timestamp = Get-Date -Format 'yyyyMMddHHmmss'

##############################################################################

$osType = "windows"
$osInstallers = @("winget", "scoop", "choco")

##############################################################################

# function Do-Help {
#     Write-Host "install.ps1 ${scriptVersion}"
#     Write-Host "--------------------------------------------------------------------------------"
# }

# function Debug {
#     param ([string]$Message)
#     if ($env:Debug) {
#         Write-Host "Debug: $Message" -ForegroundColor Gray
#     }
# }

# function Info {
#     param ([string]$Message)
#     Write-Host "INFO: $Message" -ForegroundColor Green
# }

# function Error {
#     param ([string]$Message)
#     Write-Host "ERROR: $Message" -ForegroundColor Red
#     exit 1
# }

# function ArrayContains {
#     param ([string]$Value, [string[]]$Array)
#     return $Array -contains $Value
# }

# function ArrayRemoveItem {
#     param ([string]$Item, [string[]]$Array)
#     return $Array | Where-Object { $_ -ne $Item }
# }

# function CapitalizeFirstLetter {
#     param ([string]$String)
#     return $String.Substring(0, 1).ToUpper() + $String.Substring(1).ToLower()
# }

# function FunctionExists {
#     param ([string]$FunctionName)
#     return (Get-Command $FunctionName -ErrorAction SilentlyContinue) -ne $null
# }

# function HookWingetBraveBefore {
#     Write-Host "Running pre-installation hook for Brave (Winget)"
#     # Custom logic for Winget Brave before installation
# }

# function HookChocoBraveBefore {
#     Write-Host "Running pre-installation hook for Brave (Chocolatey)"
#     choco install -y curl
#     curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
#     echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | Out-File /etc/apt/sources.list.d/brave-browser-release.list
#     choco install -y brave
# }

# function HookScoopBraveBefore {
#     Write-Host "Running pre-installation hook for Brave (Scoop)"
#     # Custom logic for Scoop Brave before installation
# }

# function HookGitAfter {
#     git config --global color.ui auto
#     git config --global core.autocrlf false
#     git config --global core.eol lf
#     git config --global push.default matching
# }

# function HookNeovimAfter {
#     if (-not (Test-Path -Path "$HOME\.config\nvim")) {
#         git clone git@github.com:dragoscirjan/neovim-config.git "$HOME\.config\nvim"
#     }
# }

# function HookNeovimBefore {
#     if (-not (Get-Command gcc -ErrorAction SilentlyContinue)) {
#         if (-not (Get-Command g++ -ErrorAction SilentlyContinue)) {
#             if (-not (Get-Command clangd -ErrorAction SilentlyContinue)) {
#                 Error "Could not find compiler"
#             }
#         }
#     }

#     if (Get-Command choco -ErrorAction SilentlyContinue) {
#         choco install -y ripgrep fd
#     }
# }

# function InstallCustomChrome {
#     Write-Host "Custom installation logic for Chrome"
#     choco install -y googlechrome
# }

# function InstallCustomBun {
#     Write-Host "Custom installation logic for Bun"
#     Invoke-WebRequest -Uri "https://bun.sh/install" -OutFile "install.bun.ps1"
#     ./install.bun.ps1
# }

# function InstallCustomDeno {
#     Write-Host "Custom installation logic for Deno"
#     Invoke-WebRequest -Uri "https://deno.land/install.sh" -OutFile "install.deno.ps1"
#     ./install.deno.ps1
# }

# function InstallCustomNode {
#     Write-Host "Custom installation logic for Node.js"
#     Invoke-WebRequest -Uri "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh" -OutFile "install.nvm.ps1"
#     ./install.nvm.ps1
# }

# function InstallUsingWinget {
#     param ([string[]]$Packages)
#     Info "The following packages will be installed using Winget: $($Packages -join ', ')"
#     foreach ($Package in $Packages) {
#         winget install --id $Package -e --source winget
#     }
# }

# function InstallUsingScoop {
#     param ([string[]]$Packages)
#     Info "The following packages will be installed using Scoop: $($Packages -join ', ')"
#     foreach ($Package in $Packages) {
#         scoop install $Package
#     }
# }

# function InstallUsingChoco {
#     param ([string[]]$Packages)
#     Info "The following packages will be installed using Chocolatey: $($Packages -join ', ')"
#     foreach ($Package in $Packages) {
#         choco install $Package -y
#     }
# }

function AppListAdd() {
    param (
        [string[]]$AppList,
        [string]$AddType,
        [string]$AddList
    )
    
    $FilteredApps = Get-Content $scriptAppsList | ConvertFrom-Json | Where-Object { $_.type -eq $AddType } | Select-Object -ExpandProperty name
    $DefaultFilteredApps = Get-Content $scriptAppsList | ConvertFrom-Json | Where-Object { $_.type -eq $AddType -and $_.default -eq $true } | Select-Object -ExpandProperty name
    if ( $AddList.Length -gt 0 ) {
        $apps = $AddList -split "," | ForEach-Object { $_.Trim() } | Where-Object { $_ -in $FilteredApps }
        $AppList += $apps
    } else {
        $AppList += $DefaultFilteredApps
    }

    $AppList
}

# ##############################################################################

$paramObject = [PSCustomObject]@{
    Browser             = $Browser
    BrowserList         = $BrowserList
    Font                = $Font
    FontList            = $FontList
    Git                 = $Git
    GitList             = $GitList
    Ide                 = $Ide
    IdeList             = $IdeList
    Im                  = $Im
    ImList              = $ImList
    Language            = $Language
    LanguageList        = $LanguageList
    Office              = $Office
    OfficeList          = $OfficeList
    Rest                = $Rest
    RestList            = $RestList
    Ssl                 = $Ssl
    SslList             = $SslList
    Vm                  = $Vm
    VmList              = $VmList
    Vpn                 = $Vpn
    VpnList             = $VpnList
}

Get-Content $scriptAppsList | ConvertFrom-Json | ForEach-Object { $_.type } | Sort-Object -Unique | ForEach-Object {
    $prop = $_.Trim()
    if ($paramObject | Select-Object -ExpandProperty $prop) {
        $list = $paramObject | Select-Object -ExpandProperty "${prop}List"
        $AppList = AppListAdd -AppList $AppList -AddType $prop -AddList $list
    }
}

if ($preferredInstallers.Count -eq 0) {
    $preferredInstallers = $osInstallers
}

# echo $AppTypes
# echo $preferredInstallers
# echo $AppList

# $installers = @()
# foreach ($installer in $preferredInstallers) {
#     $installers += $installer
#     $osInstallers = ArrayRemoveItem -Item $installer -Array $osInstallers
# }
# $installers += $osInstallers

# $AppListString = $AppList -join ', '
# Info "The following apps will be installed: $AppListString"

# foreach ($installer in $installers) {
#     $Installer = CapitalizeFirstLetter -String $installer
    
#     $packageList = @()
#     $usedAppList = @()

#     foreach ($app in $AppList) {
#         $appPackageList = Get-Content $scriptAppsList | ConvertFrom-Json | Where-Object { $_.name -eq $app } | Select-Object -ExpandProperty installers | Select-Object -ExpandProperty $installer
#         if ($appPackageList) {
#             $usedAppList += $app
#             $packageList += $appPackageList
#         }
#     }

#     foreach ($app in $usedAppList) {
#         $AppList = ArrayRemoveItem -Item $app -Array $AppList
        
#         $beforeHook = "Hook${Installer}${app}Before"
#         if (FunctionExists -FunctionName $beforeHook) {
#             Info "Running hook: $beforeHook"
#             Invoke-Expression $beforeHook
#         }
#     }

#     Invoke-Expression "InstallUsing$Installer" -ArgumentList $packageList

#     foreach ($app in $usedAppList) {
#         $afterHook = "Hook${Installer}${app}After"
#         if (FunctionExists -FunctionName $afterHook) {
#             Info "Running hook: $afterHook"
#             Invoke-Expression $afterHook
#         }

#         $afterHook = "Hook${app}After"
#         if (FunctionExists -FunctionName $afterHook) {
#             Info "Running hook: $afterHook"
#             Invoke-Expression $afterHook
#         }
#     }

#     if ($AppList.Count -gt 0) {
#         Info "Remaining apps: $($AppList -join ', ')"
#     }
# }

# if ($AppList.Count -gt 0) {
#     $AppListString = $AppList -join ', '
#     Error "The following apps could not be installed: $AppListString"
# }

# Info "All apps installed successfully"




# function Install-Utilities {
#     param (
#         [string[]]$category,
#         [string[]]$names,
#         [switch]$update
#     )

#     foreach ($cat in $category) {
#         if ($apps.ContainsKey($cat)) {
#             $AppList = $apps[$cat]
#             foreach ($app in $AppList) {
#                 if ($names -contains $app.name) {
#                     foreach ($installer in $app.installers) {
#                         switch ($installer.type) {
#                             'brew' { Install-Brew -packages $installer.packages -options $installer.options }
#                             'choco' { Install-Choco -packages $installer.packages }
#                             'scoop' { Install-Scoop -packages $installer.packages }
#                             'winget' { Install-Winget -packages $installer.packages }
#                             'apt' { Install-Apt -packages $installer.packages }
#                         }
#                     }
#                 }
#             }
#         } else {
#             Write-Host "Category $cat does not exist in configuration."
#         }
#     }
# }
