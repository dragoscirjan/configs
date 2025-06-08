

# Backup and link PowerShell_profile.ps1 using $PROFILE
$timestamp = [Math]::Floor((Get-Date -UFormat "%s"))
$dst = $PROFILE
if (Test-Path $dst) {
  Write-Host "Backing up existing profile to $dst.bak.$timestamp"
  Move-Item $dst "$dst.bak.$timestamp"
}
$src = Join-Path $PSScriptRoot 'PowerShell_profile.ps1'
if (!(Test-Path (Split-Path $dst))) { New-Item -ItemType Directory -Path (Split-Path $dst) -Force | Out-Null }
New-Item -ItemType SymbolicLink -Path $dst -Target $src -Force | Out-Null
Write-Host "Linked $src to $dst"
