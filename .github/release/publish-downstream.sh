#!/usr/bin/env bash
# Qualification downstream publisher.
#
# It records the published release under the engine-supplied idempotency key and
# refuses a duplicate record. The engine runs it once per published release, so a
# retry after a successful publication must not reach this command again; if it
# ever does, the same key is already present and the command exits 0 without
# writing a second record, which is exactly the contract a real tap replay needs.
set -euo pipefail
# Hook commands receive only the explicitly forwarded variables, so restore a
# usable search path before invoking tools by name.
export PATH="${PATH:-/usr/local/bin:/usr/bin:/bin}"

: "${CONTINUUM_RELEASE_VERSION:?missing release version}"
: "${CONTINUUM_RELEASE_TAG:?missing release tag}"
: "${CONTINUUM_SOURCE_SHA:?missing source sha}"
: "${CONTINUUM_SYNC_KEY:?missing sync key}"

workspace="$(dirname "$(git rev-parse --show-toplevel)")"
record_dir="$workspace/evidence"
mkdir -p "$record_dir"
record="$record_dir/downstream-publisher.json"

python3 - "$record" <<'PY'
import json, os, sys

path = sys.argv[1]
entry = {
    "destination": os.environ["CONTINUUM_DESTINATION"],
    "key": os.environ["CONTINUUM_SYNC_KEY"],
    "version": os.environ["CONTINUUM_RELEASE_VERSION"],
    "tag": os.environ["CONTINUUM_RELEASE_TAG"],
    "source_sha": os.environ["CONTINUUM_SOURCE_SHA"],
    "artifacts": [line for line in os.environ["CONTINUUM_ARTIFACTS"].splitlines() if line],
}
try:
    with open(path, encoding="utf-8") as handle:
        payload = json.load(handle)
except FileNotFoundError:
    payload = {"records": []}
records = payload.setdefault("records", [])
if any(item.get("key") == entry["key"] for item in records):
    print(f"already recorded {entry['key']}")
    raise SystemExit(0)
records.append(entry)
with open(path, "w", encoding="utf-8") as handle:
    json.dump(payload, handle, indent=2, sort_keys=True)
    handle.write("\n")
print(f"recorded {entry['key']}")
PY
