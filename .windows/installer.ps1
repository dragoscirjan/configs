param(
    [Parameter(Mandatory=$true)][String]$file='',
    [String]$arguments='--'
)


# https://powershellexplained.com/2016-10-21-powershell-installing-msi-files/
if ($arguments = '--') {
    Start-Process "$file" -NoNewWindow -Wait 
} else {
    Start-Process "$file" -NoNewWindow -Wait -ArgumentList "$arguments"
}