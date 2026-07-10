# Lesson 18: Debugging and quality

## Goal

Debug shell scripts by checking syntax, tracing execution, fixing quoting problems, and replacing unsafe actions with previews.

## Why this matters

Shell scripts often fail for reasons that are hard to see: an empty variable, a filename with spaces, a glob that matched too much, or an error message hidden in the wrong stream.

## Before you start

Run:

```sh
cd sandbox
```

You will inspect scripts under `scripts/` and create fixed copies under `out/`.

## Mental model

Debug in layers:

1. Syntax: can Bash parse the script?
2. Trace: what commands does Bash actually run?
3. Data: what values are variables holding?
4. Safety: could this command affect more files than intended?

Do not start by rewriting everything. First make the bug visible.

## Commands introduced

```sh
bash -n SCRIPT
bash -x SCRIPT ARGS...
shellcheck SCRIPT
```

Option meanings:

- `bash -n`: parse the script without executing it.
- `bash -x`: print each command after expansion before running it.
- `shellcheck`: optional external tool that points out common shell problems.

## Exercise 1: Check syntax

Run:

```sh
bash -n scripts/broken-report.sh
echo $?
```

If the status is `0`, Bash can parse the script. That does not mean the script is correct.

## Exercise 2: Trace execution

Run:

```sh
bash -x scripts/broken-report.sh logs/auth.log > out/broken-trace-output.txt 2> out/broken-trace-debug.txt || true
```

Then inspect:

```sh
less out/broken-trace-debug.txt
```

What to look for:

- variables expanded to empty strings;
- paths split at spaces;
- globs such as `*.log` expanded earlier than expected;
- commands that write outside `out/`.

## Exercise 3: Fix the broken report script

Copy the script:

```sh
cp scripts/broken-report.sh out/fixed-report.sh
```

Edit `out/fixed-report.sh` so it:

- has `set -euo pipefail`;
- rejects missing input;
- quotes variables;
- does not loop over `$(find ...)`;
- writes output under `out/`.

Then run:

```sh
bash -n out/fixed-report.sh
bash out/fixed-report.sh logs/auth.log
```

## Exercise 4: Turn unsafe cleanup into a preview

Copy the unsafe script:

```sh
cp scripts/unsafe-cleanup.sh out/safe-cleanup.sh
```

Edit `out/safe-cleanup.sh` so it:

- requires a target directory;
- refuses an empty target;
- prints temp and backup files it would affect;
- does not delete anything.

## Challenge

If `shellcheck` is installed, run:

```sh
shellcheck out/fixed-report.sh out/safe-cleanup.sh
```

Read each warning. Do not blindly silence warnings; understand them.

## When it goes wrong

- If `bash -n` passes but the script fails, the problem is runtime behavior, not syntax.
- If `bash -x` output is overwhelming, redirect stdout and stderr to separate files as shown above.
- If a cleanup script contains `rm -rf "$target"/*`, stop and add validation plus a preview before any deletion.

## Check yourself

Run:

```sh
bash -n out/fixed-report.sh
bash -n out/safe-cleanup.sh
```

## Next lesson

Next you will combine many tools into realistic pipelines.
