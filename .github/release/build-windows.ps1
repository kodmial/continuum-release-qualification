$ErrorActionPreference = "Stop"
New-Item -ItemType Directory -Force -Path dist | Out-Null
$staging = Join-Path ([System.IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString())
New-Item -ItemType Directory -Force -Path $staging | Out-Null
Copy-Item app/hello.txt (Join-Path $staging "hello.txt")
Set-Content -Path (Join-Path $staging "BUILD-INFO.txt") -Value @(
  "version=$env:CONTINUUM_RELEASE_VERSION",
  "source=$env:CONTINUUM_SOURCE_SHA",
  "target=$env:CONTINUUM_TARGET_ID"
)
Compress-Archive -Path (Join-Path $staging "*") -DestinationPath "dist/hello-$env:CONTINUUM_RELEASE_VERSION-windows-x64.zip" -Force
Remove-Item -Recurse -Force $staging
