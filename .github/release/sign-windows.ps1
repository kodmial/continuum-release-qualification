$ErrorActionPreference = "Stop"
Set-Content -Path dist/signature-windows.txt -Value @(
  "signer=qualification-ci",
  "version=$env:CONTINUUM_RELEASE_VERSION",
  "source=$env:CONTINUUM_SOURCE_SHA"
)
