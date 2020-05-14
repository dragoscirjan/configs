param(
    [String]$ext='ttf'
)

$ShellAppFontNamespace = 0x14
$ShellApp = New-Object -ComObject Shell.Application
$FontsFolder = $ShellApp.NameSpace($ShellAppFontNamespace)

Start-Job -Name "DetectAndClosePrompt" -Scriptblock {
  $i=1
  [void] [System.Reflection.Assembly]::LoadWithPartialName("'System.Windows.Forms")
  [void] [System.Reflection.Assembly]::LoadWithPartialName("'Microsoft.VisualBasic")
  while ($i -eq 1) {
    $windowPrompt = Get-Process -ErrorAction SilentlyContinue |? {$_.MainWindowTitle -like "*Installing Fonts*"}
    [Microsoft.VisualBasic.Interaction]::AppActivate($windowPrompt.ID)
    [System.Windows.Forms.SendKeys]::SendWait("{Enter}")
    sleep 2
  }
}

Get-Childitem -Path ~\Downloads\fonts -Include *$ext -File -Recurse -ErrorAction SilentlyContinue | Foreach {
    Write-Host "Installing font: $_"
    $FontsFolder.CopyHere($_.fullname, 16+4)
}

Get-Job DetectAndClosePrompt | Remove-Job -Force

# Remove-Item -Recurse -Force fonts
