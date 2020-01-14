#! /bin/bash

DOWNLOAD_URL=
DOWNLOAD_GENERIC_URL=
DOWNLOAD_GENERIC_MATCH=

PACKAGE=
PACKAGE_TYPE=deb

#####################################################################
# Params parsing
#####################################################################

## using --a=b
#for i in "$@"
#do
#case $i in
#    -e=*|--extension=*)
#    EXTENSION="${i#*=}"
#    shift # past argument=value
#    ;;
#    -s=*|--searchpath=*)
#    SEARCHPATH="${i#*=}"
#    shift # past argument=value
#    ;;
#    -l=*|--lib=*)
#    LIBPATH="${i#*=}"
#    shift # past argument=value
#    ;;
#    --default)
#    DEFAULT=YES
#    shift # past argument with no value
#    ;;
#    *)
#          # unknown option
#    ;;
#esac
#done

# using --a b
POSITIONAL=()
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -pa=*|--package=*)
    PACKAGE="${key#*=}"
    shift # past argument=value
    ;;
    -pa|--package)
    PACKAGE="$2"
    shift # past argument
    shift # past value
    ;;

    -pt=*|--package-type=*)
    PACKAGE_TYPE="${key#*=}"
    shift # past argument=value
    ;;
    -pt|--package-type)
    PACKAGE_TYPE="$2"
    shift # past argument
    shift # past value
    ;;
    -pr=*|--package-repo=*)
    PACKAGE="${key#*=}"
    shift # past argument=value
    ;;
    -pr|--package-repo)
    PACKAGE="$2"
    shift # past argument
    shift # past value
    ;;

    -url=*|--download-url=*)
    DOWNLOAD_URL="${key#*=}"
    shift # past argument=value
    ;;
    -url|--download-url)
    DOWNLOAD_URL="$2"
    shift # past argument
    shift # past value
    ;;

    -gurl=*|--generic-url=*)
    DOWNLOAD_GENERIC_URL="${key#*=}"
    shift # past argument=value
    ;;
    -gurl|--generic-url)
    DOWNLOAD_GENERIC_URL="$2"
    shift # past argument
    shift # past value
    ;;

    -gmatch=*|--generic-match=*)
    DOWNLOAD_GENERIC_MATCH="${key#*=}"
    shift # past argument=value
    ;;
    -gmatch|--generic-match)
    DOWNLOAD_GENERIC_MATCH="$2"
    shift # past argument
    shift # past value
    ;;

    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
  esac
done

set -- "${POSITIONAL[@]}" # restore positional parameters

echo "Package: $PACKAGE"
echo "Package Type: $PACKAGE_TYPE"
echo "Download url: $DOWNLOAD_URL"
echo "Download generic url: $DOWNLOAD_GENERIC_URL"
echo "Download generic match: $DOWNLOAD_GENERIC_MATCH"
echo "Leftovers: $@"

# exit 0

#####################################################################
# Install script
#####################################################################

do_install_curl() {
	which curl > /dev/null && return 0
	which apt > /dev/null && apt install -y curl && return 0
	which apt-get > /dev/null && apt-get install -y curl && return 0
	# ... TODO for other Linux Distros that I may use
}

do_check_file_downloaded() {
	local toMatch = $1
  while [[ "" == "" ]]; do
    read -p "Was the file downloaded? [Y/n]" -n 1 -r confirm
    echo # move to new line
    if [[ $confirm == "" ]]; then confirm = "y"; fi
    case "$confirm" in
      y|Y )
        ls -la $HOME/Downloads | grep "$DOWNLOAD_GENERIC_MATCH" > /dev/null && break
		    echo "Could not detect installable file. Please check that downloaded file matches $DOWNLOAD_GENERIC_MATCH string."
        break;;
      * )
        echo "Blah! You messed up, Jim!"
        exit 1
    esac
	done
}

do_install_local_package() {
  case $2 in
    deb)
      sudo dpkg -i $1 || apt-get install -fy;
      ;;
    *)
      echo "Invalid package type.";
      exit 0;
      ;;
  esac
}

do_install_package() {
  local package=$1
  local packageType=$2
  local packageRepo=$3
  case $packageType in
    deb)
      sudo apt-get install -y $package;
      ;;
    dmg)
      brew $packageRepo list | grep $package || brew $packageRepo install $package
      brew $packageRepo list | grep $package && brew $packageRepo reinstall $package
      ;;
    *)
      echo "Invalid package type.";
      exit 0;
      ;;
  esac
}

do_install_curl

mkdir -p ~/bin
mkdir -p ~/Downloads

if [[ "$DOWNLOAD_URL" != "" ]]; then
	curl -SL "$DOWNLOAD_URL" --output "$HOME/Downloads/package.$PACKAGE_TYPE"
  do_install_local_package "$HOME/Downloads/package.$PACKAGE_TYPE" $PACKAGE_TYPE
fi

if [[ "$DOWNLOAD_GENERIC_URL" != "" ]]; then
  if [[ "$DOWNLOAD_GENERIC_MATCH" == "" ]]; then
    echo -e "No match defined."
    exit 1
  fi
	echo -e "We will redirect you to \e[36m$DOWNLOAD_GENERIC_URL\e[0m, in order to download the required package. "
  echo -e "Please save it under \e[36m\$HOME/Downloads\e[0m folder."
	sleep 5
	xdg-open "$DOWNLOAD_GENERIC_URL" || gnome-open "$DOWNLOAD_GENERIC_URL"
  slee 5
  do_check_file_downloaded "$DOWNLOAD_GENERIC_MATCH"
  do_install_local_package "$HOME/Downloads/$(ls -la $HOME/Downloads | grep "$DOWNLOAD_GENERIC_MATCH" | sort | head -n 1 | awk '{ print $NF }')" deb
fi

if [[ "$PACKAGE" != "" ]]; then
  do_install_package $PACKAGE $PACKAGE_TYPE $PACKAGE_REPO
fi
