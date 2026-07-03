#!/usr/bin/env bash
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
script=$root/sandbox/out/log-summary.sh

[ -x "$script" ] || { printf 'FAIL: create executable sandbox/out/log-summary.sh\n'; exit 1; }
bash -n "$script"
"$script" "$root/sandbox/logs/app-2026-06-01.log" >/tmp/pipeworks-log-summary-check.txt
grep -q 'ERROR' /tmp/pipeworks-log-summary-check.txt || { printf 'FAIL: log-summary.sh output should mention ERROR\n'; exit 1; }
rm -f /tmp/pipeworks-log-summary-check.txt

printf 'PASS: basic shell script works.\n'
