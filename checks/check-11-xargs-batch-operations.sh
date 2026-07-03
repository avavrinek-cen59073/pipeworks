#!/usr/bin/env bash
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
out=$root/sandbox/out

[ -s "$out/xargs-delete-preview.txt" ] || { printf 'FAIL: missing sandbox/out/xargs-delete-preview.txt\n'; exit 1; }
grep -q '^rm ' "$out/xargs-delete-preview.txt" || { printf 'FAIL: preview should contain rm commands, not perform them\n'; exit 1; }
grep -Eq '(\.tmp|\.bak|~)' "$out/xargs-delete-preview.txt" || { printf 'FAIL: preview should target temp or backup files\n'; exit 1; }

printf 'PASS: xargs preview looks correct.\n'
