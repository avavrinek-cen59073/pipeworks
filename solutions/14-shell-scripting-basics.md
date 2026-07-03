# Solutions 14: Shell scripting basics

## Exercise 1

Task: Create `out/log-summary.sh`.

One solution is the script shown in the lesson:

```sh
#!/usr/bin/env bash
set -euo pipefail

log_file=${1:-}
if [ -z "$log_file" ]; then
  printf 'Usage: %s LOGFILE\n' "${0##*/}" >&2
  exit 2
fi

if [ ! -f "$log_file" ]; then
  printf 'Missing file: %s\n' "$log_file" >&2
  exit 1
fi

printf 'File: %s\n' "$log_file"
printf 'ERROR lines: '
grep -c 'level=ERROR' "$log_file"
```

Why this works: it validates input before reading the file.

## Exercise 2

Task: Make it executable.

```sh
chmod +x out/log-summary.sh
```

## Exercise 3

Task: Run it and save output.

```sh
out/log-summary.sh logs/app-2026-06-01.log > out/log-summary-output.txt
```

## Exercise 4

Task: Test missing input.

```sh
out/log-summary.sh > out/log-summary-missing.txt 2>&1 || printf 'script rejected missing input\n'
```

## Challenge

Add:

```sh
printf 'WARN lines: '
grep -c 'level=WARN' "$log_file"
```
