$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.IO.Compression

# Build a byte-reproducible ZIP: fixed entry order, fixed timestamps, and no
# platform-dependent archive metadata. A rebuild from the same commit and
# version therefore yields the same digest, which is what lets the release
# engine resume a draft against the receipts it already recorded.
New-Item -ItemType Directory -Force -Path dist | Out-Null
$staging = Join-Path ([System.IO.Path]::GetTempPath()) ([guid]::NewGuid().ToString())
New-Item -ItemType Directory -Force -Path $staging | Out-Null
Copy-Item app/hello.txt (Join-Path $staging "hello.txt")
Set-Content -Path (Join-Path $staging "BUILD-INFO.txt") -Encoding utf8NoBOM -Value @(
  "version=$env:CONTINUUM_RELEASE_VERSION",
  "source=$env:CONTINUUM_SOURCE_SHA",
  "target=$env:CONTINUUM_TARGET_ID"
)

$zipPath = Join-Path (Get-Location) "dist/hello-$env:CONTINUUM_RELEASE_VERSION-windows-x64.zip"
if (Test-Path $zipPath) { Remove-Item -Force $zipPath }

$fixed = [DateTimeOffset]::new(2026, 1, 1, 0, 0, 0, [TimeSpan]::Zero)
$stream = [System.IO.File]::Open($zipPath, [System.IO.FileMode]::CreateNew)
try {
  $archive = New-Object System.IO.Compression.ZipArchive($stream, [System.IO.Compression.ZipArchiveMode]::Create, $true)
  try {
    foreach ($name in @("BUILD-INFO.txt", "hello.txt")) {
      $entry = $archive.CreateEntry($name, [System.IO.Compression.CompressionLevel]::Optimal)
      $entry.LastWriteTime = $fixed
      $entryStream = $entry.Open()
      try {
        $input = [System.IO.File]::OpenRead((Join-Path $staging $name))
        try { $input.CopyTo($entryStream) } finally { $input.Dispose() }
      } finally { $entryStream.Dispose() }
    }
  } finally { $archive.Dispose() }
} finally { $stream.Dispose() }

Remove-Item -Recurse -Force $staging
