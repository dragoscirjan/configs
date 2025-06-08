
$profilePath = [System.IO.FileInfo]::new($MyInvocation.MyCommand.Path).FullName
$profileRealPath = if ([System.IO.File]::Exists($profilePath)) {
    try {
        $resolved = [System.IO.FileInfo]::new((Get-Item $profilePath).Target)
        if ($resolved.Exists) { $resolved.DirectoryName } else { Split-Path $profilePath }
    } catch { Split-Path $profilePath }
} else { Split-Path $profilePath }
$OhMyPoshConfig = Join-Path $profileRealPath 'ohmyposh.config.toml'

oh-my-posh init pwsh --config $OhMyPoshConfig | Invoke-Expression
