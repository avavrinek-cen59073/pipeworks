# Solutions 18: Debugging and quality

## Exercise 1

Task: Run a syntax check.

```sh
bash -n scripts/broken-report.sh
```

Why this works: `bash -n` parses without executing. It does not catch every logic error.

## Exercise 2

Task: Trace execution.

```sh
bash -x scripts/broken-report.sh logs/auth.log > out/broken-trace-output.txt 2> out/broken-trace-debug.txt || true
```

Why this works: `-x` shows expanded commands on stderr.

## Exercise 3

Task: Fix the report script.

One fixed core loop:

```sh
#!/usr/bin/env bash
set -euo pipefail

input=${1:-}
[ -n "$input" ] || { printf 'Usage: %s LOGFILE\n' "${0##*/}" >&2; exit 2; }
[ -f "$input" ] || { printf 'Missing file: %s\n' "$input" >&2; exit 1; }

out_file=out/fixed-errors.txt
grep 'level=ERROR' "$input" > "$out_file"
printf 'Wrote %s\n' "$out_file"
```

Why this works: it validates input, quotes variables, and writes to `out/`.

## Exercise 4

Task: Create a safe cleanup preview.

```sh
#!/usr/bin/env bash
set -euo pipefail

target=${1:-}
[ -n "$target" ] || { printf 'Usage: %s DIR\n' "${0##*/}" >&2; exit 2; }
[ -d "$target" ] || { printf 'Missing directory: %s\n' "$target" >&2; exit 1; }

find "$target" -type f \( -name '*.tmp' -o -name '*.bak' -o -name '*~' \) -print
```

Common mistake: keeping `rm -rf $target/*`.

## Challenge

```sh
command -v shellcheck >/dev/null 2>&1 && shellcheck out/fixed-report.sh out/safe-cleanup.sh
```
