param(
    [Parameter(Mandatory=$true)][String]$url='',
    [String]$output=''
)

# https://blog.jourdant.me/post/3-ways-to-download-files-with-powershell

# @see https://stackoverflow.com/questions/41618766/powershell-invoke-webrequest-fails-with-ssl-tls-secure-channel
[Net.ServicePointManager]::SecurityProtocol = 
  [Net.SecurityProtocolType]::Tls12 -bor `
  [Net.SecurityProtocolType]::Tls11 -bor `
  [Net.SecurityProtoolType]::Tls

if ($output) {
    Invoke-WebRequest -Uri "$url" -OutFile "$output"
} else {
    (new-object system.net.webclient).DownloadString($url)
}