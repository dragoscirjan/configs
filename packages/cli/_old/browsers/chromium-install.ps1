param(
  [String]$DirInstall='../.install'
)


$WebResponse = Invoke-WebRequest "https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Win%2FLAST_CHANGE?generation=1588717823791629&alt=media"

$ChromiumVersion = $WebResponse.Content

make --directory=$DirInstall iu PACKAGE_URL="https://commondatastorage.googleapis.com/chromium-browser-snapshots/index.html?prefix=Win/$ChromiumVersion/" PACKAGE_MATCH="Win_.*_installer.exe" PACKAGE_ARGS="/silent /install"
