# Lesson 17: Functions and structure

## Goal

Organize a Bash script into small functions for usage, errors, logging, validation, and processing.

## Why this matters

Once a script grows past a few lines, structure matters. Functions make it easier to see what the script checks, what it prints, and where the real work happens.

## Before you start

Run:

```sh
cd sandbox
```

You will create `out/function-report.sh`.

## Mental model

A function is a named block of commands:

```sh
name() {
  commands
}
```

Functions can receive arguments just like scripts: inside a function, `$1` is the function's first argument.

Use `return` for success/failure status. Use stdout when a function needs to output text.

## Syntax introduced

```sh
name() { ...; }
local variable=value
return 0
main "$@"
```

What it means:

- `local` keeps a variable inside the function.
- `main "$@"` passes all script arguments to the `main` function.
- `die` is a common name for a function that prints an error and exits.

## Exercise 1: Create a structured script

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

Read it by function name first: usage, error handling, logging, main workflow.

## Exercise 2: Run the script

Run:

```sh
chmod +x out/function-report.sh
out/function-report.sh logs/app-2026-06-02.log
```

You should see an info message and a count.

## Exercise 3: Separate data from diagnostics

Run:

```sh
out/function-report.sh logs/app-2026-06-02.log > out/function-count.txt 2> out/function-debug.txt
cat out/function-count.txt
cat out/function-debug.txt
```

This works because the count is printed to stdout, while `log_info` prints to stderr.

## Exercise 4: Add a processing function

Add this function:

```sh
print_error_lines() {
  local log_file=$1
  grep 'level=ERROR' "$log_file"
}
```

Then call it from `main` after the count.

## Challenge

Add a `validate_log_file` function and move the file-existence check into it.

## When it goes wrong

- If a variable leaks between functions, use `local`.
- If a function uses `$1`, check whether you passed an argument to that function.
- If logs and report data mix together, send diagnostics to stderr with `>&2`.

## Compatibility notes

This lesson uses Bash function style and `local`. Use a Bash shebang for scripts like this.

## Check yourself

Confirm that stdout contains report data and stderr contains the `INFO:` log line.

## Next lesson

Next you will debug scripts and improve shell quality.
