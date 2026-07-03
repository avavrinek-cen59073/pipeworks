# Lesson 14: Shell scripting basics

## Goal

Create a Bash script with a shebang, executable permissions, variables, quoting, command substitution, exit codes, and strict mode.

## Why this matters

Scripts turn repeatable terminal workflows into reliable tools.

## Before you start

```sh
cd sandbox
```

Required files are in `logs/`.

## Mental model

A script is a text file interpreted by a shell. The shebang chooses the interpreter. Quoting keeps data intact.

## Commands introduced

- `#!/usr/bin/env bash`
- `chmod +x`
- variables
- quoting
- command substitution
- exit codes
- `set -euo pipefail`

## Exercise 1: Smallest useful version

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

## Exercise 2: Add one option

Make it executable:

```sh
chmod +x out/log-summary.sh
```

## Exercise 3: Combine with previous knowledge

Run it:

```sh
out/log-summary.sh logs/app-2026-06-01.log > out/log-summary-output.txt
cat out/log-summary-output.txt
```

## Exercise 4: Realistic task

Test the missing-input path:

```sh
out/log-summary.sh > out/log-summary-missing.txt 2>&1 || printf 'script rejected missing input\n'
cat out/log-summary-missing.txt
```

## Challenge

Add a second count for `WARN` lines.

## Common mistakes

- Forgetting `chmod +x`.
- Using `$1` when no argument was provided while `set -u` is enabled.
- Leaving variables unquoted.

## GNU/Linux vs macOS notes

The script uses portable Bash and common external commands.

## Bash vs zsh notes

This is a Bash script. Run it directly after `chmod +x`, or with `bash out/log-summary.sh ...`.

## Check yourself

From the repository root:

```sh
./checks/check-14-shell-scripting-basics.sh
```

## Next lesson

Next you will add script arguments and options.
