# Lesson 18: Debugging and quality

## Goal

Use syntax checks, trace mode, optional ShellCheck, and careful reviews to fix broken shell scripts.

## Why this matters

Shell bugs often come from missing quotes, unsafe globs, unhandled arguments, and loops that break filenames.

## Before you start

```sh
cd sandbox
```

Required scripts are in `scripts/`.

## Mental model

Debugging is observation. First check syntax, then trace execution, then make the smallest safe fix.

## Commands introduced

- `bash -n`
- `bash -x`
- optional: `shellcheck`

## Exercise 1: Smallest useful version

Run a syntax check:

```sh
bash -n scripts/broken-report.sh
```

Syntax can pass even when logic is wrong.

## Exercise 2: Add one option

Trace execution:

```sh
bash -x scripts/broken-report.sh logs/auth.log > out/broken-trace-output.txt 2> out/broken-trace-debug.txt || true
```

Read the debug file.

## Exercise 3: Combine with previous knowledge

Copy the broken script and fix it in `out/fixed-report.sh`. Fix at least:

- missing argument handling;
- unquoted variables;
- unsafe `find` loop;
- output path.

## Exercise 4: Realistic task

Improve `scripts/unsafe-cleanup.sh` as `out/safe-cleanup.sh` so it:

- requires a target directory;
- refuses empty targets;
- previews matching temp and backup files;
- does not delete originals.

## Challenge

If `shellcheck` is installed, run it on your fixed scripts and decide which warnings matter.

## Common mistakes

- Treating `bash -n` as proof the script is correct.
- Keeping `for file in $(find ...)`.
- Adding broad error suppression instead of fixing the cause.

## GNU/Linux vs macOS notes

`shellcheck` is optional and may not be installed by default.

## Bash vs zsh notes

Debug Bash scripts with Bash, even if your interactive shell is zsh.

## Check yourself

Run:

```sh
bash -n out/fixed-report.sh
bash -n out/safe-cleanup.sh
```

## Next lesson

Next you will combine many tools into realistic pipelines.
