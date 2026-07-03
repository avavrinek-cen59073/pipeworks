#!/usr/bin/env bash
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
out=$root/sandbox/out

[ -s "$out/empty-files.txt" ] || { printf 'FAIL: missing sandbox/out/empty-files.txt\n'; exit 1; }
[ -s "$out/cleanup-preview.txt" ] || { printf 'FAIL: missing sandbox/out/cleanup-preview.txt\n'; exit 1; }

grep -q 'empty-file.txt' "$out/empty-files.txt" || { printf 'FAIL: empty-files.txt should include empty-file.txt\n'; exit 1; }
grep -Eq '(\.tmp|\.bak|~)' "$out/cleanup-preview.txt" || { printf 'FAIL: cleanup-preview.txt should include temp or backup files\n'; exit 1; }

printf 'PASS: find lesson outputs look correct.\n'
