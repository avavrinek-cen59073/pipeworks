#!/usr/bin/env bash
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
out=$root/sandbox/out

[ -s "$out/expenses-by-department.txt" ] || { printf 'FAIL: missing sandbox/out/expenses-by-department.txt\n'; exit 1; }
grep -q '^Engineering ' "$out/expenses-by-department.txt" || { printf 'FAIL: expenses report should include Engineering\n'; exit 1; }
grep -q '^Sales ' "$out/expenses-by-department.txt" || { printf 'FAIL: expenses report should include Sales\n'; exit 1; }

printf 'PASS: awk lesson outputs look correct.\n'
