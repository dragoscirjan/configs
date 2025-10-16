param(
    [Parameter(Mandatory=$true)]
    [string]$Item
)

# Normalize the path by removing trailing backslashes
$NormalizedItem = $Item.TrimEnd('\')

# Check if the item is already in PATH
$PathItems = $env:PATH -split ';' | Where-Object { $_.TrimEnd('\') -ieq $NormalizedItem }

if (-not $PathItems) {
    # Add to PATH
    [Environment]::SetEnvironmentVariable('PATH', $env:PATH + ';' + $Item, [EnvironmentVariableTarget]::User)
    Write-Host "Added '$Item' to PATH" -ForegroundColor Green

    # Update current session PATH
    $env:PATH = $env:PATH + ';' + $Item
    Write-Host "PATH updated for current session" -ForegroundColor Yellow
} else {
    Write-Host "'$Item' already in PATH" -ForegroundColor Cyan
}
