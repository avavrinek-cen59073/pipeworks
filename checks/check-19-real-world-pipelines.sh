#!/usr/bin/env bash
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
out=$root/sandbox/out

for file in failure-report.txt config-audit.txt duplicate-users-report.txt; do
  [ -s "$out/$file" ] || { printf 'FAIL: missing sandbox/out/%s\n' "$file"; exit 1; }
done

grep -q 'code=' "$out/failure-report.txt" || { printf 'FAIL: failure-report.txt should include error codes\n'; exit 1; }
grep -q 'old-db.internal' "$out/config-audit.txt" || { printf 'FAIL: config-audit.txt should include deprecated host\n'; exit 1; }
grep -q 'u002' "$out/duplicate-users-report.txt" || { printf 'FAIL: duplicate-users-report.txt should include u002\n'; exit 1; }

printf 'PASS: real-world pipeline outputs look correct.\n'
