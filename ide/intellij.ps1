param(
    [Parameter(Mandatory=$true)][String]$url=''
)

$output = (new-object system.net.webclient).DownloadString($url) | ConvertFrom-Json

echo $output.IIU.downloads.windows.link