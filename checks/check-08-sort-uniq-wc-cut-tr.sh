#!/usr/bin/env bash
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
out=$root/sandbox/out

[ -s "$out/users.txt" ] || { printf 'FAIL: missing sandbox/out/users.txt\n'; exit 1; }
[ -s "$out/duplicate-user-ids.txt" ] || { printf 'FAIL: missing sandbox/out/duplicate-user-ids.txt\n'; exit 1; }
[ -s "$out/status-counts.txt" ] || { printf 'FAIL: missing sandbox/out/status-counts.txt\n'; exit 1; }

grep -q '^alice$' "$out/users.txt" || { printf 'FAIL: users.txt should include alice\n'; exit 1; }
grep -q '^u002$' "$out/duplicate-user-ids.txt" || { printf 'FAIL: duplicate-user-ids.txt should include u002\n'; exit 1; }
grep -q 'failed' "$out/status-counts.txt" || { printf 'FAIL: status-counts.txt should include failed\n'; exit 1; }

printf 'PASS: sort/uniq/cut/tr outputs look correct.\n'
