#!/usr/bin/env bash
set -euo pipefail
printf 'signer=qualification-ci\nversion=%s\nsource=%s\n' "$CONTINUUM_RELEASE_VERSION" "$CONTINUUM_SOURCE_SHA" > dist/signature-linux.txt
