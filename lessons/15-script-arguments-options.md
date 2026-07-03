# Lesson 15: Script arguments and options

## Goal

Parse script arguments, support simple options, print usage, and reject unknown flags.

## Why this matters

Scripts become easier to use when they have predictable options such as `--help`, `--count`, and `--errors-only`.

## Before you start

Run:

```sh
cd sandbox
```

You will work on `out/log-tool.sh`.

## Mental model

When a script starts:

- `$0` is the script name.
- `$1` is the first argument.
- `$2` is the second argument.
- `$#` is the number of arguments.
- `"$@"` means all arguments, preserved as separate words.
- `shift` discards `$1` and moves the rest left.

Options are just arguments by convention. Your script decides what `--count` means.

## Syntax introduced

```sh
case "$1" in
  --help) ... ;;
  --count) ... ;;
  --*) ... ;;
esac
shift
usage() { ...; }
```

What it means:

- `case` compares a value against patterns.
- `--*)` matches any argument that starts with `--`.
- `;;` ends a branch.
- `shift` is what lets a parser move to the next argument.

## Exercise 1: Start from a working script

Run:

```sh
cp scripts/parse-log.sh out/log-tool.sh
chmod +x out/log-tool.sh
out/log-tool.sh logs/auth.log
```

Why copy it? Fixture scripts should remain unchanged so you can reset and compare.

## Exercise 2: Add `--help`

Edit `out/log-tool.sh` so this works:

```sh
out/log-tool.sh --help
```

Expected behavior:

- Print a usage line.
- Exit successfully.
- Do not require a log file when `--help` is used.

## Exercise 3: Add `--count`

Edit the script so this works:

```sh
out/log-tool.sh --count logs/auth.log
```

Expected behavior: print only the count of `level=ERROR` lines.

## Exercise 4: Add `--errors-only` and reject bad options

Support this shape:

```sh
out/log-tool.sh [--help] [--count] [--errors-only] LOGFILE
```

Also test:

```sh
out/log-tool.sh --bad-option logs/auth.log
echo $?
```

The script should reject the unknown option and exit non-zero.

## Challenge

Support options before or after the log path without accepting two log paths.

## When it goes wrong

- If the script loops forever, check whether each handled option calls `shift`.
- If `--bad-option` is treated as a filename, add a `--*)` rejection branch.
- If paths with spaces break, use `"$@"`, `"$1"`, and quoted variables.

## Check yourself

Run:

```sh
out/log-tool.sh --help
out/log-tool.sh --count logs/auth.log
out/log-tool.sh --bad-option logs/auth.log
```

## Next lesson

Next you will use conditionals and loops.
