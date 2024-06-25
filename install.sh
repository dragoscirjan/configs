#!/bin/bash
if [[ ! -z "$DEBUG" ]]; then
    set -ex
fi

scriptDir=$(dirname "$0")
scriptName=$(basename "$0")
scriptVersion=""
scriptAppsList="./apps.json"
timestamp=$(date '+%Y%m%d%H%M%S')

##############################################################################

osType="darwin"
osInstallers=("brew")
[ -f /etc/os-release ] && . /etc/os-release && osType="$NAME" && osInstallers=("apt" "apt-get" "snap")
[ -f /etc/lsb-release ] && . /etc/lsb-release && osType="$DISTRIB_ID" && osInstallers=("apt" "apt-get" "snap")
[ -f /etc/redhat-release ] && osType=$(cat /etc/redhat-release | awk '{print $1}') && osInstallers=("apt" "apt-get" "snap")
[ -f /etc/debian_version ] && osType="debian" && osInstallers=("apt" "apt-get" "snap")



##############################################################################

do_help() {

  cat >&2 <<EOF
install.sh ${scriptVersion}
--------------------------------------------------------------------------------
EOF

  # local maxLen=0
  # while read t; do
  #   if [[ ${#t} -gt $maxLen ]]; then
  #     maxLen=${#t}
  #   fi
  # done < <(jq -r '.[].type' $scriptAppsList | sort | uniq)
  # maxLen=$((maxLen + 4))

  # while read t; do
  #   printf "%-${maxLen}s" "--$t"
  #   echo "message"
  # done < <(jq -r '.[].type' $scriptAppsList | sort | uniq)

}

capitalizeFirstLetter() {
  echo "$1" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}'
}

debug() {
  if [[ ! -z "$DEBUG" ]]; then
    echo "DEBUG: $1"
  fi
}

arrayContains() {
  local value="$1"
  shift
  for element; do
    [[ "$element" == "$value" ]] && return 0
  done
  return 1
}

# Function to remove an item from an array
arrayRemoveItem() {
  local item="$1"
  shift
  local -a array=("$@")
  local -a newArray=()

  for element in "${array[@]}"; do
    if [[ "$element" != "$item" ]]; then
      newArray+=("$element")
    fi
  done

  echo "${newArray[@]}"
}

# installByPackageManager() {

# }

installUsingBrew() {
  nonCask=()
  cask=()
  for package in "$@"; do
    if [[ "$package" == "cask/"* ]]; then
      cask+=("${package:5}")
    else
      nonCask+=("$package")
    fi
  done

  echo brew install -f ${nonCask[@]}
  echo brew install -f ${cask[@]} --cask
}

##############################################################################


# TODO validate_apps_json_exists

POSITIONAL_ARGS=()

appList=()
appTypes=($(jq -r '.[].type' $scriptAppsList | sort | uniq))
preferredInstallers=()

while [[ $# -gt 0 ]]; do
  case $1 in
    
    --preferred-installers)
      read -r -a installers <<< "$2"
      for installer in "${installers[@]}"; do
        preferredInstallers+=("$installer")
      done
      shift # past argument
      shift # past value
      ;;
    -h|--help)
      do_help
      exit 0
      ;;
    --*)
      appType="${1#--}"
      if arrayContains "$appType" "${appTypes[@]}"; then
        debug "'$appType' selected"
        if [[ "$2" != --* ]] && [[ "$2" != "" ]]; then
          read -r -a apps <<< "$2"
          for app in "${apps[@]}"; do
            appList+=("$app")
          done
          shift # past value
        else
          defaultApps=($(jq -r --arg type "$appType" '.[] | select(.type == $type and .default == true) | .name' "$scriptAppsList"))
          for app in "${defaultApps[@]}"; do
            appList+=("$app")
          done
        fi
      else
        echo "Unknown option $1"
        exit 1
      fi
      shift # past argument
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

##############################################################################

# Declare an empty array
myArray=()

# Check if the array is empty
if [ ${#preferredInstallers[@]} -eq 0 ]; then
  preferredInstallers=(${osInstallers[@]})
fi


for installer in "${preferredInstallers[@]}"; do
  # osInstallers=($(arrayRemoveItem "$installer" "${osInstallers[@]}"))
  packageList=()

  for app in "${appList[@]}"; do
    appPackageList=($(jq -r --arg name "$app" --arg installer "$installer" '
        .[] | select(.name == $name) | .installers[$installer] // empty | if . == [] then "[]" else .[] end
      ' $scriptAppsList))
    if [ ${#appPackageList[@]} -ne 0 ]; then
      for package in "${appPackageList[@]}"; do
        packageList+=("$package")
      done
    fi
  done

  Installer=$(capitalizeFirstLetter $installer)
  "installUsing$Installer" "${packageList[@]}"
done

# for installer in "${osInstallers[@]}"; do
#   echo "Installer: $installer"
# done




# # https://snapcraft.io/docs/installing-snapd


# apt_install() {
# 	sudo apt-get update;
# 	sudo apt-get install -y \
# 		git \
# 		make \
# 		snapd \
# 		;
# }

# which apt-get > /dev/null && apt_install


# mkdir -p ~/bin
# git clone https://github.com/dragoscirjan/configs

# # ( sudo apt-get update && sudo apt-get install -y snapd ) \
# # 	|| ( sudo apt update && sudo apt install -y snapd ) \
# # 	|| sudo dnf install snapd \
# # 	|| ( sudo zypper addrepo --refresh https://download.opensuse.org/repositories/system:/snappy/openSUSE_Leap_15.0 snappy \
# # 			&& sudo zypper --gpg-auto-import-keys refresh && sudo zypper dup --from snappy && sudo zypper install snapd ) \
# # 	|| ( sudo yum install epel-release && sudo yum install snapd )
