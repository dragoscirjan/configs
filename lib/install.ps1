

function Install-Choco {
  param (
    [string[]]$packages
  )
  foreach ($package in $packages) {
    Write-Host "Installing $package using Chocolatey..."
    choco install $package -y
  }
}

function Install-Scoop {
  param (
    [string[]]$packages
  )
  foreach ($package in $packages) {
    Write-Host "Installing $package using Scoop..."
    scoop install $package
  }
}

function Install-Winget {
  param (
    [string[]]$packages
  )
  foreach ($package in $packages) {
    Write-Host "Installing $package using Winget..."
    winget install --id $package -e --source winget
  }
}
