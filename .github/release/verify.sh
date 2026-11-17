#!/usr/bin/env bash
set -euo pipefail
test -s "dist/hello-$CONTINUUM_RELEASE_VERSION-$CONTINUUM_TARGET_ID.tar.gz"
test -s dist/signature-linux.txt
