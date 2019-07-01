param(
	[String]$url='',
	[Parameter(Mandatory=$false)][ValidateSet("true", "false")][String]$isFile="false"
)


switch($isFile.ToLower()) {
    "true" {
        mkdir .\fonts
        # -SkipCertificateCheck
        # @see https://stackoverflow.com/questions/41618766/powershell-invoke-webrequest-fails-with-ssl-tls-secure-channel
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri "$url" -OutFile .\fonts\font.ttf   
    }
    default {
        # -SkipCertificateCheck
        # @see https://stackoverflow.com/questions/41618766/powershell-invoke-webrequest-fails-with-ssl-tls-secure-channel
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri "$url" -OutFile fonts.zip
        Expand-Archive .\fonts.zip -DestinationPath .\fonts
        Remove-Item fonts.zip
    }
}


$ShellAppFontNamespace = 0x14
$ShellApp = New-Object -ComObject Shell.Application
$FontsFolder = $ShellApp.NameSpace($ShellAppFontNamespace)

Get-Childitem -Path .\fonts -Include *ttf -File -Recurse -ErrorAction SilentlyContinue| Foreach {
	Write-Verbose -Message ('Installing font: {0}' -f $_.fullname)
    $FontsFolder.CopyHere($_.fullname)
}

Remove-Item -Recurse -Force fonts