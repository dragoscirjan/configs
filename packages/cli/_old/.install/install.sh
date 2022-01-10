#! /bin/bash

ArgumentList=""
File=""
FileMatch=""
FileMatchRetries=20
Message=""
Url=""
WaitBetweenAttempts=15
DestinationPath="/opt"

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -al|--argument-list)
    ArgumentList="$2"
    shift # past argument
    shift # past value
    ;;
    -d|--destination-path)
    DestinationPath="$2"
    shift # past argument
    shift # past value
    ;;
    -f|--file)
    File="$2"
    shift # past argument
    shift # past value
    ;;
    -fm|--file-match)
    FileMatch="$2"
    shift # past argument
    shift # past value
    ;;
    -fmr|--file-match-retries)
    FileMatchRetries="$2"
    shift # past argument
    shift # past value
    ;;
    -u|--url)
    Url="$2"
    shift # past argument
    shift # past value
    ;;
    -wba|--wait-between-attempts)
    WaitBetweenAttempts="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done

echo "File: $File"
echo "Url: $Url"
echo "FileMatch: $FileMatch"
echo "FileMatchRetries: $FileMatchRetries"
echo "WaitBetweenAttempts: $WaitBetweenAttempts"
echo "Message: $Message"
echo "ArgumentList: $ArgumentList"
echo "DestinationPath: $DestinationPath"

function DoInstall() {

  # if ($ArgumentList -ne "") {
  #   $ArgumentList = $ArgumentList -replace "__HOME__",$Env:UserProfile
  #   $ArgumentList = $ArgumentList -replace "__PROGRAMFILES__",$Env:ProgramFiles
  # }

  echo "Installing: $File"
  echo "with arguments: $ArgumentList"
  echo ""

  echo $File | grep -e ".\+\.tar\.gz\$" > /dev/null && sudo tar -xzf $File -C $DestinationPath #$ArgumentList
  echo $File | grep -e ".\+\.tgz\$" > /dev/null && sudo tar -xzf $File -C $DestinationPath #$ArgumentList

  echo "Done."
}

function WaitAndInstall() {

  while [[ $FileMatchRetries -gt 0 ]]; do
    File=$(ls $HOME/Downloads | grep -e "$FileMatch")
    if [[ "$File" != "" ]]; then
      File="$HOME/Downloads/$File"
      DoInstall
      return
    fi
    FileMatchRetries=$(($FileMatchRetries-1))
  done

  echo "Number of retries exceeded. File not found. Exiting."
  echo ""
  exit 1
}

if [[ "$Url" != "" ]]; then
  echo "url install"

  if [[ "$FileMatch" == "" ]]; then
    echo "Please either mention --FileMatch as arguments."
    exit 1
  fi

  echo "You will be redirected to this url: $Url."
  echo "Please download the file to ~/Downloads and rename it to contain the following string: $FileMatch"
  if [[ "$Message" != "" ]]; then
    echo $Message
  fi
  echo ""

  read
  echo ""

  xdg-open "$Url" || gnome-open "$Url"

  echo "Press any key to continue after installer is downloaded..."
  read
  echo ""

  WaitAndInstall
else
  if [[ "$File" != "" ]]; then
    File=$(realpath $File)
    DoInstall
  else
    echo "Please either mention --url either --file as arguments."
    exit 1
  fi
fi
