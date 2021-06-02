# Part of this file is copied from
# https://github.com/fsaintjacques/semver-tool/blob/master/src/semver
# Project's license is GPL 3


SEMVER_REGEX="^(0|[1-9][0-9]*)(\\.(0|[1-9][0-9]*))?(\\.(0|[1-9][0-9]*))?(\\-[0-9A-Za-z-]+(\\.[0-9A-Za-z-]+)*)?(\\+[0-9A-Za-z-]+(\\.[0-9A-Za-z-]+)*)?$"

# function validate_version {
#   local version=$1
#   if [[ "$version" =~ $SEMVER_REGEX ]]; then
#     # if a second argument is passed, store the result in var named by $2
#     if [ "$#" -eq "2" ]; then
#       local major=${BASH_REMATCH[1]}
#       local minor=${BASH_REMATCH[2]}
#       local patch=${BASH_REMATCH[3]}
#       local prere=${BASH_REMATCH[4]}
#       local build=${BASH_REMATCH[5]}
#       eval "$2=(\"$major\" \"$minor\" \"$patch\" \"$prere\" \"$build\")"
#     else
#       echo "$version"
#     fi
#   else
#     error "version $version does not match the semver scheme 'X.Y.Z(-PRERELEASE)(+BUILD)'. See help for more information."
#   fi
# }

function fill_version {
  local version=$1
  if [[ "$version" =~ $SEMVER_REGEX ]]; then
    # if a second argument is passed, store the result in var named by $2
    local major=${BASH_REMATCH[1]}
    local minor=${BASH_REMATCH[3]}
    local patch=${BASH_REMATCH[5]}
    local prere=${BASH_REMATCH[6]}
    local build=${BASH_REMATCH[7]}
    if [[ "$minor" == "" ]]; then minor=0; fi
    if [[ "$patch" == "" ]]; then patch=0; fi
    filled_version="$major.$minor.$patch$prere$build"
    if [ "$#" -eq "2" ]; then
      eval "$2=\"$filled_version\""
    else
      echo $filled_version
    fi
  else
    error "version $version does not match the semver scheme 'X.Y.Z(-PRERELEASE)(+BUILD)'. See help for more information."
    exit 1
  fi
}
