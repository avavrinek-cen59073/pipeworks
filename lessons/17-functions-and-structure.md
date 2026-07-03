# Lesson 17: Functions and structure

## Goal

Refactor script logic into functions with clear validation, usage, logging, and error handling.

## Why this matters

Functions make scripts easier to read, test, and change without duplicating logic.

## Before you start

```sh
cd sandbox
```

Use scripts under `out/`.

## Mental model

A function names a small piece of behavior. Keep validation, reporting, and command execution separated.

## Commands introduced

- `name() { ...; }`
- `local`
- `return`

## Exercise 1: Smallest useful version

Create `out/function-report.sh`:

```sh
#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: %s LOGFILE\n' "${0##*/}"
}

die() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

log_info() {
  printf 'INFO: %s\n' "$*" >&2
}

main() {
  local log_file=${1:-}
  [ -n "$log_file" ] || { usage >&2; exit 2; }
  [ -f "$log_file" ] || die "missing file: $log_file"
  log_info "reading $log_file"
  grep -c 'level=ERROR' "$log_file"
}

main "$@"
```

## Exercise 2: Add one option

Make it executable and run it:

```sh
chmod +x out/function-report.sh
out/function-report.sh logs/app-2026-06-02.log
```

## Exercise 3: Combine with previous knowledge

Redirect stdout and stderr separately:

```sh
out/function-report.sh logs/app-2026-06-02.log > out/function-count.txt 2> out/function-debug.txt
```

## Exercise 4: Realistic task

Add a `print_error_lines` function that prints matching error lines after the count.

## Challenge

Add a `validate_log_file` function and call it from `main`.

## Common mistakes

- Using globals when a `local` variable is clearer.
- Returning text with `return`; use stdout for text and return for status.
- Hiding errors by redirecting everything to `/dev/null`.

## GNU/Linux vs macOS notes

The Bash function syntax used here works on both systems.

## Bash vs zsh notes

This script is Bash-specific because it uses Bash conventions and should be run with Bash.

## Check yourself

Confirm that stdout contains data and stderr contains the `INFO:` log line.

## Next lesson

Next you will debug scripts and improve shell quality.
