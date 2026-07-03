# Lesson 15: Script arguments and options

## Goal

Use positional arguments, argument counts, shifting, option parsing with `case`, and usage functions.

## Why this matters

Good scripts explain how to run them, reject unknown options, and support common flags.

## Before you start

```sh
cd sandbox
```

Use `out/log-tool.sh` for this lesson.

## Mental model

Arguments are strings passed to a script. Options are just arguments with conventions. Your script decides how to interpret them.

## Commands introduced

- `$1`
- `$2`
- `$@`
- `$#`
- `shift`
- `case`
- usage functions

## Exercise 1: Smallest useful version

Create a script that accepts a log path and prints matching lines:

```sh
cp scripts/parse-log.sh out/log-tool.sh
chmod +x out/log-tool.sh
out/log-tool.sh logs/auth.log
```

## Exercise 2: Add one option

Add a `--help` branch that prints usage and exits successfully.

## Exercise 3: Combine with previous knowledge

Add `--count` so the script prints only a count of `level=ERROR` lines.

## Exercise 4: Realistic task

Add `--errors-only` and reject unknown options with exit status 2.

Expected usage shape:

```sh
out/log-tool.sh [--help] [--count] [--errors-only] LOGFILE
```

## Challenge

Support options before or after the log path without accepting multiple log paths.

## Common mistakes

- Parsing options but forgetting to `shift`.
- Treating unknown options as filenames.
- Printing usage to stdout for errors instead of stderr.

## GNU/Linux vs macOS notes

This lesson avoids non-portable `getopt` behavior.

## Bash vs zsh notes

The script should run with Bash because of the shebang. The concepts are similar in zsh, but syntax details can differ.

## Check yourself

Run these manually:

```sh
out/log-tool.sh --help
out/log-tool.sh --count logs/auth.log
out/log-tool.sh --bad-option logs/auth.log
```

## Next lesson

Next you will use conditionals and loops.
