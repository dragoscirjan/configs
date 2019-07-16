param(
    [Parameter(Mandatory=$true)][String]$url='',
    [Parameter(Mandatory=$true)][String]$output=''
)

# @see https://stackoverflow.com/questions/41618766/powershell-invoke-webrequest-fails-with-ssl-tls-secure-channel
[Net.ServicePointManager]::SecurityProtocol = 
  [Net.SecurityProtocolType]::Tls12 -bor `
  [Net.SecurityProtocolType]::Tls11 -bor `
  [Net.SecurityProtocolType]::Tls

Invoke-WebRequest -Uri "$url" -OutFile "$output"