#!/usr/bin/env bash
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
out=$root/sandbox/out

[ -s "$out/app-no-comments.conf" ] || { printf 'FAIL: missing sandbox/out/app-no-comments.conf\n'; exit 1; }
[ -s "$out/database-migrated.conf" ] || { printf 'FAIL: missing sandbox/out/database-migrated.conf\n'; exit 1; }

if grep -Eq '^[[:space:]]*#|^[[:space:]]*$' "$out/app-no-comments.conf"; then
  printf 'FAIL: app-no-comments.conf should not contain comments or blank lines\n'
  exit 1
fi
grep -q 'db.internal.local' "$out/database-migrated.conf" || { printf 'FAIL: database-migrated.conf should include db.internal.local\n'; exit 1; }

printf 'PASS: sed lesson outputs look correct.\n'
