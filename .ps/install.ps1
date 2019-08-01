param(
    [Parameter(Mandatory=$true)][String]$file='',
    [String]$args=''
)

$file=Resolve-Path -Path $file; 

if ($file.Split(".")[1] -ne "msi") {
    echo $file
    if ($args -ne '') {
        Start-Process -FilePath $file -ArgumentList $args -NoNewWindow -Wait;
    } else {
        Start-Process -FilePath $file -NoNewWindow -Wait;
    }
} else {
    if ($args -ne '') {
        Start-Process -FilePath msiexec.exe -ArgumentList '/i',$file,'/q',$args -Wait -PassThru -Verb 'RunAs';
    } else {
        Start-Process -FilePath msiexec.exe -ArgumentList '/i',$file,'/q' -Wait -PassThru -Verb 'RunAs';
    }
}