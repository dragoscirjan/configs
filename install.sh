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
if [[ -f /etc/lsb-release ]]; then 
  . /etc/lsb-release
  osType="$DISTRIB_ID"
  osInstallers=("snap" "apt")
else
  if [[ -f /etc/debian_version ]]; then
    osType="debian"
    osInstallers=("snap" "apt")
  fi
fi
# [ -f /etc/os-release ] && . /etc/os-release && osType="$NAME" && osInstallers=("snap" "apt")
# [ -f /etc/redhat-release ] && osType=$(cat /etc/redhat-release | awk '{print $1}') && osInstallers=("snap" "yum")



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

debug() {
  # if [[ ! -z "$DEBUG" ]]; then
    echo -e "\e[90mDEBUG: $1\e[0m"
  # fi
}

info() {
  echo -e "\e[32mINFO: $1\e[0m"
}

error() {
  echo -e "\e[31mERROR: $1\e[0m"
  exit 1
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

capitalizeFirstLetter() {
  echo "$1" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}'
}

functionExists() {
  if declare -F "$1" > /dev/null; then
    return 0
  else
    return 1
  fi
}

hookAptBraveBefore() {
  # TODO: fix properly
  sudo apt install curl
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
}

hookAptEdgeBefore() {
  # TODO: fix properly
  # https://linuxconfig.org/how-to-install-microsoft-edge-on-ubuntu-debian-linux
  # https://www.omgubuntu.co.uk/2021/01/how-to-install-edge-on-ubuntu-linux
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
  sudo rm microsoft.gpg
  sudo apt update
}

hookAptOperaBefore() {
  # TODO: fix properly
  wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
  echo "deb https://deb.opera.com/opera-stable/ stable non-free" | sudo tee /etc/apt/sources.list.d/opera-stable.list
  sudo apt update
}

hookAptVivaldiBefore() {
  # TODO: fix properly
  # https://itsfoss.com/install-vivaldi-ubuntu-linux/
  wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor | sudo dd of=/usr/share/keyrings/vivaldi-browser.gpg
  echo "deb [signed-by=/usr/share/keyrings/vivaldi-browser.gpg arch=$(dpkg --print-architecture)] https://repo.vivaldi.com/archive/deb/ stable main" | sudo dd of=/etc/apt/sources.list.d/vivaldi-archive.list
  sudo apt update
}

hookGitAfter() {
  git config --global color.ui auto
  git config --global core.autocrlf false
  git config --global core.eol lf
  git config --global push.default matching
}

hookNeovimAfter() {
  [ -d ~/.config/nvim ] || git clone git@github.com:dragoscirjan/neovim-config.git ~/.config/nvim
}

# https://www.lazyvim.org/#%EF%B8%8F-requirements
hookNeovimBefore() {
  # https://github.com/nvim-treesitter/nvim-treesitter#requirements
  which gcc > /dev/null || which g++ > /dev/null || which clangd > /dev/null || error "Could not find compiler"

  which apt > /dev/null && sudo apt update && sudo apt install -y ripgrep fd-find
}

installCustomDebianChrome() {
  # https://askubuntu.com/questions/79280/how-to-install-chrome-browser-properly-via-command-line
  # TODO: fix properly
  sudo apt update
  sudo curl -fsSLo /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt install -y /tmp/google-chrome*.deb
  sudo apt install -yf
}

installCustomUbuntuChrome() {
  installCustomDebianChrome
}

installCustomBun() {
  # https://bun.sh/docs/installation
  curl -fsSL https://bun.sh/install | bash # for macOS, Linux, and WSL
}

installCustomDeno() {
  # https://deno.com/
  curl -fsSL https://deno.land/install.sh | bash
}

installCustomNode() {
  # https://github.com/nvm-sh/nvm/blob/master/README.md#installing-and-updating
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
}

installUsingApt() {
  info "The following packages will be installed using apt: $@"

  sudo apt update
  echo "sudo apt install -y $@"
}

installUsingAptGet() {
  info "The following packages will be installed using apt: $@"

  sudo apt update
  echo "sudo apt install -y $@"
}

installUsingBrew() {
  info "The following packages will be installed using brew: $@"

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

installUsingSnap() {
  packagesString="$@"
  info "The following packages will be installed using snap: $packagesString"

  nonClassic=()
  classic=()
  for package in "$@"; do
    if [[ "$package" == "classic/"* ]]; then
      classic+=("${package:8}")
    else
      nonClassic+=("$package")
    fi
  done

  if [[ ${#nonClassic[@]} -gt 0 ]]; then
    for package in "${nonClassic[@]}"; do
      sudo snap install $package
    done
  fi
  if [[ ${#classic[@]} -gt 0 ]]; then
    for package in "${classic[@]}"; do
      sudo snap install $package --classic
    done
  fi
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
        debug "Type '$appType' selected"
        if [[ "$2" != --* ]] && [[ "$2" != "" ]]; then
          read -r -a apps <<< "$2"
          for app in "${apps[@]}"; do
            appList+=("$app")
          done
          shift # past value
        else
          defaultApps=($(jq -r --arg type "$appType" '.[] | select(.type == $type and .default == true) | .name' "$scriptAppsList"))
          defaultAppsString="${defaultApps[@]}"
          debug "Default apps for type '$appType': $defaultAppsString"
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

installers=()
for installer in "${preferredInstallers[@]}"; do
  installers+=($installer)
  osInstallers=($(arrayRemoveItem "$installer" "${osInstallers[@]}"))
done
for installer in "${osInstallers[@]}"; do
  installers+=($installer)
done

appListString="${appList[@]}"
info "The following apps will be installed: $appListString"

for installer in "${installers[@]}"; do
  Installer=$(capitalizeFirstLetter $installer)
  
  packageList=()
  usedAppList=()

  for app in "${appList[@]}"; do
    appPackageList=($(jq -r --arg name "$app" --arg installer "$installer" '
        .[] | select(.name == $name) | .installers[$installer] // empty | if . == [] then "[]" else .[] end
      ' $scriptAppsList))
    if [ ${#appPackageList[@]} -ne 0 ]; then
      usedAppList+=($app)
      for package in "${appPackageList[@]}"; do
        packageList+=("$package")
      done
    fi
  done

  for app in "${usedAppList[@]}"; do
    appList=($(arrayRemoveItem "$app" "${appList[@]}"))
  
    beforeHook="hook$(capitalizeFirstLetter $app)Before"
    if functionExists "$beforeHook"; then
      info "Running hook: $beforeHook"
      $beforeHook
    fi
  
    beforeHook="hook${Installer}$(capitalizeFirstLetter $app)Before"
    if functionExists "$beforeHook"; then
      info "Running hook: $beforeHook"
      $beforeHook
    fi
  done
  
  "installUsing$Installer" "${packageList[@]}"

  for app in "${usedAppList[@]}"; do
    afterHook="hook${Installer}$(capitalizeFirstLetter $app)After"
    if functionExists "$afterHook"; then
      info "Running hook: $afterHook"
      $afterHook
    fi

    afterHook="hook$(capitalizeFirstLetter $app)After"
    if functionExists "$afterHook"; then
      info "Running hook: $afterHook"
      $afterHook
    fi
  done

  if [[ ${#appList[@]} -gt 0 ]]; then
    info "Remaining apps: ${appList[@]}"
  fi
done

# search for custom installers
if [[ ${#appList[@]} -gt 0 ]]; then
  appListString="${appList[@]}"
  info "The following apps need custom installers: $appListString"

  usedAppList=()
  for app in "${appList[@]}"; do
    name=$app
    if [[ "$app" == */* ]]; then
      # Split by /
      IFS='/' read -ra parts <<< "$app"
      name="${parts[1]}"
    fi

    customInstaller="installCustom$(capitalizeFirstLetter $osType)$(capitalizeFirstLetter $name)"
    if functionExists "$customInstaller"; then
      info "Running custom installer: $customInstaller"
      $customInstaller
      usedAppList+=($app)
    fi

    customInstaller="installCustom$(capitalizeFirstLetter $name)"
    if functionExists "$customInstaller"; then
      info "Running custom installer: $customInstaller"
      $customInstaller
      usedAppList+=($app)
    fi
  done

  for app in "${usedAppList[@]}"; do
    appList=($(arrayRemoveItem "$app" "${appList[@]}"))
  done
fi

# throw error if still having uninstalled apps
if [ ${#appList[@]} -ne 0 ]; then
  appListString="${appList[@]}"
  error "The following apps could not be installed: $appListString"
fi

info "All apps installed successfuly"