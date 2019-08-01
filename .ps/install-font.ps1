$ShellAppFontNamespace = 0x14
$ShellApp = New-Object -ComObject Shell.Application
$FontsFolder = $ShellApp.NameSpace($ShellAppFontNamespace)

Get-Childitem -Path ~\tmp\fonts -Include *ttf -File -Recurse -ErrorAction SilentlyContinue | Foreach {
    Write-Verbose -Message ('Installing font: {0}' -f $_.fullname)
    $FontsFolder.CopyHere($_.fullname)
}

# Remove-Item -Recurse -Force fonts