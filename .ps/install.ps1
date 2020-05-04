param(
    # [Parameter(Mandatory=$true)]
    [String]$File="",
    [String]$Url="",
    [String]$FileMatch="",
    [Int]$FileMatchRetries=20,
    [Int]$WaitBetweenAttempts=15,
    [String]$Message="",
    [String]$ArgumentList=""
)

Function Pause($Message = "Press any key to continue...")
{
   # Check if running in PowerShell ISE
   If ($psISE) {
      # "ReadKey" not supported in PowerShell ISE.
      # Show MessageBox UI
      $Shell = New-Object -ComObject "WScript.Shell"
      $Button = $Shell.Popup("Click OK to continue.", 0, "Hello", 0)
      Return
   }

   $Ignore =
      16,  # Shift (left or right)
      17,  # Ctrl (left or right)
      18,  # Alt (left or right)
      20,  # Caps lock
      91,  # Windows key (left)
      92,  # Windows key (right)
      93,  # Menu key
      144, # Num lock
      145, # Scroll lock
      166, # Back
      167, # Forward
      168, # Refresh
      169, # Stop
      170, # Search
      171, # Favorites
      172, # Start/Home
      173, # Mute
      174, # Volume Down
      175, # Volume Up
      176, # Next Track
      177, # Previous Track
      178, # Stop Media
      179, # Play
      180, # Mail
      181, # Select Media
      182, # Application 1
      183  # Application 2

   Write-Host -NoNewline $Message
   While ($KeyInfo.VirtualKeyCode -Eq $Null -Or $Ignore -Contains $KeyInfo.VirtualKeyCode) {
      $KeyInfo = $Host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown")
   }
}

Function DoInstall()
{
  Param(
    [String]$File = "",
    [String]$ArgumentList = ""
  )
  Write-Host -ForegroundColor Green "Installing:" $File
  Write-Host -ForegroundColor Green "with arguments:" ($ArgumentList -Join ", ")
  Write-Host ""
  if ($File.Split(".")[1] -ne "msi") {
    if ($ArgumentList -ne "") {
        Start-Process -FilePath $File -ArgumentList $ArgumentList -NoNewWindow -Wait;
    } else {
        Start-Process -FilePath $File -NoNewWindow -Wait;
    }
  } else {
    if ($ArgumentList -ne "") {
        Start-Process -FilePath msiexec.exe -ArgumentList '/i',"$File",'/q',$ArgumentList -Wait -PassThru -Verb 'RunAs';
    } else {
        Start-Process -FilePath msiexec.exe -ArgumentList '/i',"$File",'/q' -Wait -PassThru -Verb 'RunAs';
    }
  }
  Write-Host -ForegroundColor Green "Done."
}

Function WaitAndInstall
{
  Param(
    [String]$FileMatch="",
    [String]$ArgumentList="",
    [Int]$Retries=20,
    [Int]$Sleep=15
  )

  Do
  {
    $FileDirectory = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path;
    foreach($File in Get-ChildItem $FileDirectory)
    {
      $File = $File."Name"
      if ($File -Match $FileMatch)
      {
        $FilePath = "$FileDirectory\$File"
        DoInstall -File $FilePath -ArgumentList $ArgumentList
        # Remove-Item "$FileDirectory\$File" -Recurse
        exit 0
      }
    }
    # Get-Process AcroRd32 | % { $_.CloseMainWindow() }
    $Retries = $Retries - 1
    Write-Host -ForegroundColor Yellow "Did not find download file. Waiting 15 seconds and retrying; $Retries retries left."
    Sleep $Sleep
  } While ($Retries -gt 0)
  Write-Host -ForegroundColor Red "Number of retries exceeded. File not found. Exiting."
  Write-Host ""
  exit 1
}

if ($Url -ne "")
{

  if ($FileMatch -eq "") {
    Write-Output -ForegroundColor Red "Please either mention --FileMatch as arguments."
    exit 1
  }

  Write-Host -ForegroundColor Green "You will be redirected to this url: $Url."
  Write-Host -ForegroundColor Green "Please download the file to ~/Downloads and rename it to contain the following string: $FileMatch"
  if ($Message -ne "") {
    Write-Host -ForegroundColor Green $Message
  }
  Write-Host ""

  Pause
  Write-Host ""

  Start "$Url"

  Pause -Message "Press any key to continue after installer is downloaded..."
  Write-Host ""

  WaitAndInstall -FileMatch $FileMatch -ArgumentList $ArgumentList -Retries $FileMatchRetries -Sleep $WaitBetweenAttempts

} else {
  if ($File -ne "") {
    $File = Resolve-Path -Path $File
    DoInstall -File $File -ArgumentList $ArgumentList
  } else {
    Write-Output -ForegroundColor Red "Please either mention --Url either --File as arguments."
    exit 1
  }
}
