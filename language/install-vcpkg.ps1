$prefix = Join-Path $env:USERPROFILE '.local\bin';

New-Item -ItemType Directory -Path $prefix -Force | Out-Null;

$repo = Join-Path $prefix 'vcpkg';
if (Test-Path $repo) {
  git -C $repo pull --ff-only
} else { `
  git clone --depth 1 https://github.com/microsoft/vcpkg $repo
}; `
Set-Location $repo;

if (-not (Test-Path '.\vcpkg.exe')) {
  .\bootstrap-vcpkg.bat
};

.\vcpkg integrate install;

$shim = Join-Path $prefix 'vcpkg.cmd';
$content = "@echo off`r`n`"`%~dp0vcpkg\vcpkg.exe`" %*`r`n";
Set-Content -Path $shim -Value $content -Encoding ASCII
