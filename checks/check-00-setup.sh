#!/usr/bin/env bash
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
out=$root/sandbox/out
file=$out/first-output.txt

[ -d "$root/sandbox" ] || { printf 'FAIL: sandbox directory is missing. Run ./tools/reset-sandbox.sh\n'; exit 1; }
[ -f "$file" ] || { printf 'FAIL: create sandbox/out/first-output.txt\n'; exit 1; }
grep -q 'pipeworks ready' "$file" || { printf 'FAIL: first-output.txt should contain "pipeworks ready"\n'; exit 1; }

printf 'PASS: setup output file exists.\n'
