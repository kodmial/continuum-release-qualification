#!/usr/bin/env bash
set -euo pipefail
mkdir -p dist
staging="$(mktemp -d)"
cp app/hello.txt "$staging/hello.txt"
printf 'version=%s\nsource=%s\ntarget=%s\n' "$CONTINUUM_RELEASE_VERSION" "$CONTINUUM_SOURCE_SHA" "$CONTINUUM_TARGET_ID" > "$staging/BUILD-INFO.txt"
tar --sort=name --owner=0 --group=0 --numeric-owner --mtime='UTC 2026-01-01' \
  -czf "dist/hello-$CONTINUUM_RELEASE_VERSION-linux-x64.tar.gz" -C "$staging" hello.txt BUILD-INFO.txt
rm -rf "$staging"
