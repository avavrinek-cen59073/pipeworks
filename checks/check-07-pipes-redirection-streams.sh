#!/usr/bin/env bash
set -euo pipefail

root=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
out=$root/sandbox/out

[ -s "$out/error-lines.txt" ] || { printf 'FAIL: missing sandbox/out/error-lines.txt\n'; exit 1; }
[ -s "$out/pipeline-summary.txt" ] || { printf 'FAIL: missing sandbox/out/pipeline-summary.txt\n'; exit 1; }
[ -f "$out/find-errors.txt" ] || { printf 'FAIL: missing sandbox/out/find-errors.txt\n'; exit 1; }

grep -q 'level=ERROR' "$out/error-lines.txt" || { printf 'FAIL: error-lines.txt should contain ERROR lines\n'; exit 1; }
grep -qi 'error' "$out/pipeline-summary.txt" || { printf 'FAIL: pipeline-summary.txt should mention errors\n'; exit 1; }

printf 'PASS: pipe and redirection outputs look correct.\n'
