param(
    [Parameter(Mandatory=$true)][String]$url='',
    [Parameter(Mandatory=$true)][String]$keys=''
)

$output = (new-object system.net.webclient).DownloadString($url) | ConvertFrom-Json

foreach ($key in $keys.split(',')) {
    $link = $output.$key.downloads.windows.link
    $file = Split-Path $link -leaf
    # echo $link 
    # echo $file
    make --directory=../.install iu URL="$link" FILE="~/tmp/$file"
}