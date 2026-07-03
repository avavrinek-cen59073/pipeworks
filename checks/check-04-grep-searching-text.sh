#!/usr/bin/env bash
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
out=$root/sandbox/out

[ -s "$out/errors.txt" ] || { printf 'FAIL: missing sandbox/out/errors.txt\n'; exit 1; }
[ -s "$out/error-codes.txt" ] || { printf 'FAIL: missing sandbox/out/error-codes.txt\n'; exit 1; }
[ -s "$out/deprecated-files.txt" ] || { printf 'FAIL: missing sandbox/out/deprecated-files.txt\n'; exit 1; }

grep -q 'level=ERROR' "$out/errors.txt" || { printf 'FAIL: errors.txt should contain ERROR log lines\n'; exit 1; }
grep -q 'code=E42' "$out/error-codes.txt" || { printf 'FAIL: error-codes.txt should include E42\n'; exit 1; }
grep -q 'configs/' "$out/deprecated-files.txt" || { printf 'FAIL: deprecated-files.txt should list config files\n'; exit 1; }

printf 'PASS: grep lesson outputs look correct.\n'
