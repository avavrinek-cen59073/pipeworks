#!/usr/bin/env bash
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
out=$root/sandbox/out

[ -f "$out/reports.tar" ] || { printf 'FAIL: missing sandbox/out/reports.tar\n'; exit 1; }
[ -s "$out/reports-archive-list.txt" ] || { printf 'FAIL: missing sandbox/out/reports-archive-list.txt\n'; exit 1; }
grep -q 'reports/q1.txt' "$out/reports-archive-list.txt" || { printf 'FAIL: archive list should include reports/q1.txt\n'; exit 1; }

printf 'PASS: archive lesson outputs look correct.\n'
