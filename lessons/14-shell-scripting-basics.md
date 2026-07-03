# Lesson 14: Shell scripting basics

## Goal

Write a small Bash script that validates input, quotes variables, reports errors clearly, and exits with useful status codes.

## Why this matters

A script is a command you can repeat. A good script explains what it needs and fails before doing confusing work.

## Before you start

Run:

```sh
cd sandbox
```

You will create `out/log-summary.sh`.

## Mental model

A shell script is a text file interpreted by a shell. The first line, called the shebang, tells the operating system which interpreter to use:

```sh
#!/usr/bin/env bash
```

This script will use Bash, even if your interactive shell is zsh.

## Syntax introduced

```sh
#!/usr/bin/env bash
set -euo pipefail
variable=value
"$variable"
${1:-}
if [ condition ]; then ... fi
exit 2
```

What these pieces mean:

- `set -euo pipefail`: stricter error behavior. `-e` exits on many failures, `-u` rejects unset variables, and `pipefail` catches failures inside pipelines.
- `log_file=${1:-}`: set `log_file` to the first argument, or empty if no first argument exists.
- `"$log_file"`: quote the variable so paths with spaces stay one argument.
- `>&2`: write a message to stderr.
- `exit 2`: stop the script with status 2. Many scripts use 2 for usage errors.

## Exercise 1: Create the script

Create `out/log-summary.sh` with this content:

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

Read the script before running it. The two `if` blocks validate the input before `grep` runs.

## Exercise 2: Make it executable

Run:

```sh
chmod +x out/log-summary.sh
```

What it means: `chmod +x` adds execute permission so the file can be run as a command.

## Exercise 3: Run it with a real log

Run:

```sh
out/log-summary.sh logs/app-2026-06-01.log > out/log-summary-output.txt
cat out/log-summary-output.txt
```

The log path becomes `$1` inside the script.

## Exercise 4: Test missing input

Run:

```sh
out/log-summary.sh > out/log-summary-missing.txt 2>&1 || printf 'script rejected missing input\n'
cat out/log-summary-missing.txt
```

What this teaches:

- The script should reject bad usage.
- `2>&1` captures stderr and stdout in one file.
- `||` runs the right side only if the script exits non-zero.

## Challenge

Add a second count for `WARN` lines.

## When it goes wrong

- If the script says "Permission denied", run `chmod +x out/log-summary.sh`.
- If `set -u` complains about `$1`, use `${1:-}` when an argument may be missing.
- If a filename with spaces breaks, check that every variable expansion is quoted.

## Compatibility notes

This is a Bash script. Run it as `out/log-summary.sh` after `chmod +x`, or explicitly with `bash out/log-summary.sh ...`.

## Check yourself

From the repository root:

```sh
./checks/check-14-shell-scripting-basics.sh
```

## Next lesson

Next you will add script arguments and options.
