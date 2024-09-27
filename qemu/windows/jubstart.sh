# #!/bin/bash
# set -ex

# # ubuntu version
# version=20.04

# # download destination
# destination=/tmp

# POSITIONAL=()
# while [[ $# -gt 0 ]]
# do
# key="$1"

# case $key in
#     -u|--ubuntu-version)
#     version="$2"
#     shift # past argument
#     shift # past value
#     ;;
#     -d|--destination)
#     destination="$2"
#     shift # past argument
#     shift # past value
#     ;;
#     *)    # unknown option
#     POSITIONAL+=("$1") # save it in an array for later
#     shift # past argument
#     ;;
# esac
# done
# set -- "${POSITIONAL[@]}" # restore positional parameters

# curl -sSL "https://software-download.microsoft.com/pr/Win10_20H2_v2_English_x64.iso?t=55ba18f8-3281-4a36-be8a-53997ec4f768&e=1613671211&h=8041d9bdeb0a9fae3877b42b608ac3b9" --output "$destination/windows.iso"

