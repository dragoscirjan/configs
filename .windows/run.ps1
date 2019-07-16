param(
    [Parameter(Mandatory=$true)][String]$file='',
    [String]$arguments='--'
)

if ($arguments = '--') {
    Start-Process "$file" -NoNewWindow -Wait 
} else {
    Start-Process "$file" -NoNewWindow -Wait -ArgumentList "$arguments"
}