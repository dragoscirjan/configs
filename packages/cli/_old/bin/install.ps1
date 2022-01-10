param(
    [String]$DownloadUrl='',
    [String]$GenericUrl='',
    [String]$GenericMatch='',
    [String]$Package='',
    [String]$PackageType='',
    [String]$PackageRepo=''
)

Write-Output "Package: $Package"
Write-Output "Package Type: $PackageType"
Write-Output "Download url: $DownloadUrl"
Write-Output "Download generic url: $GenericUrl"
Write-Output "Download generic match: $GenericMatch"

#####################################################################
# Install script
#####################################################################

function doCheckFileDownloaded($toMatch) {
	# local toMatch = $1
  # while [[ "" == "" ]]; do
  #   read -p "Was the file downloaded? [Y/n]" -n 1 -r confirm
  #   Write-Output # move to new line
  #   if [[ $confirm == "" ]]; then confirm = "y"; fi
  #   case "$confirm" in
  #     y|Y )
  #       ls -la $HOME/Downloads | grep "$DOWNLOAD_GENERIC_MATCH" > /dev/null && break
	# 	    Write-Output "Could not detect installable file. Please check that downloaded file matches $DOWNLOAD_GENERIC_MATCH string."
  #       break;;
  #     * )
  #       Write-Output "Blah! You messed up, Jim!"
  #       exit 1
  #   esac
	# done
}

# do_install_local_package() {
#   case $2 in
#     deb)
#       sudo dpkg -i $1 || apt-get install -fy;
#       ;;
#     *)
#       Write-Output "Invalid package type.";
#       exit 0;
#       ;;
#   esac
# }

# do_install_package() {
#   local package=$1
#   local packageType=$2
#   local packageRepo=$3
#   case $packageType in
#     deb)
#       sudo apt-get install -y $package;
#       ;;
#     dmg)
#       brew $packageRepo list | grep $package || brew $packageRepo install $package
#       brew $packageRepo list | grep $package && brew $packageRepo reinstall $package
#       ;;
#     *)
#       Write-Output "Invalid package type.";
#       exit 0;
#       ;;
#   esac
# }

# mkdir -p ~/bin
# mkdir -p ~/Downloads

if ($DownloadUrl -ne "") {
	powershell -File curl.ps1 -url "$DownloadUrl" --output "~/Downloads/package.$PackageType"
  # do_install_local_package "$HOME/Downloads/package.$PACKAGE_TYPE" $PACKAGE_TYPE
}

# if [[ "$DOWNLOAD_GENERIC_URL" != "" ]]; then
#   if [[ "$DOWNLOAD_GENERIC_MATCH" == "" ]]; then
#     Write-Output -e "No match defined."
#     exit 1
#   fi
# 	Write-Output -e "We will redirect you to \e[36m$DOWNLOAD_GENERIC_URL\e[0m, in order to download the required package. "
#   Write-Output -e "Please save it under \e[36m\$HOME/Downloads\e[0m folder."
# 	sleep 5
# 	xdg-open "$DOWNLOAD_GENERIC_URL" || gnome-open "$DOWNLOAD_GENERIC_URL"
#   slee 5
#   doCheckFileDownloaded "$DOWNLOAD_GENERIC_MATCH"
#   do_install_local_package "$HOME/Downloads/$(ls -la $HOME/Downloads | grep "$DOWNLOAD_GENERIC_MATCH" | sort | head -n 1 | awk '{ print $NF }')" deb
# fi

# if [[ "$PACKAGE" != "" ]]; then
#   do_install_package $PACKAGE $PACKAGE_TYPE $PACKAGE_REPO
# fi
