$ErrorActionPreference = "Stop"
if (-not (Test-Path "dist/hello-$env:CONTINUUM_RELEASE_VERSION-$env:CONTINUUM_TARGET_ID.zip")) { throw "artifact missing" }
if (-not (Test-Path dist/signature-windows.txt)) { throw "signature missing" }
