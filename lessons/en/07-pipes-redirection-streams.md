# Lesson 07: Pipes, redirection, and streams

## Goal

Understand stdin, stdout, stderr, exit status, pipes, overwrite redirection, append redirection, stderr redirection, and `tee`.

## Why this matters

The shell becomes useful when you can connect small commands and control where their output goes.

## Before you start

Run:

```sh
cd sandbox
```

## Mental model

Most commands have three standard streams:

- stdin: input the command reads.
- stdout: normal output.
- stderr: error messages and diagnostics.

A command also exits with a status:

- `0` usually means success.
- non-zero usually means something failed or did not match the command's expectation.

## Syntax introduced

```sh
|
>
>>
2>
2>&1
tee
echo $?
```

What each piece means:

- `A | B`: send stdout from command `A` into stdin of command `B`.
- `>`: write stdout to a file, replacing the file.
- `>>`: append stdout to a file.
- `2>`: write stderr to a file.
- `2>&1`: send stderr to the same place stdout is currently going.
- `tee FILE`: write stdin to `FILE` and also pass it to stdout.
- `$?`: the previous command's exit status.

## Exercise 1: Save normal output

Run:

```sh
grep -h 'level=ERROR' logs/*.log > out/error-lines.txt
cat out/error-lines.txt
```

The `grep` output would normally appear in your terminal. `>` sends stdout to `out/error-lines.txt` instead.

## Exercise 2: Build a summary with overwrite and append

Run:

```sh
printf 'error lines: ' > out/pipeline-summary.txt
wc -l < out/error-lines.txt >> out/pipeline-summary.txt
cat out/pipeline-summary.txt
```

What to notice:

- The first command uses `>` because it starts the file.
- The second command uses `>>` because it adds to the file.
- `< out/error-lines.txt` gives the file to `wc` as stdin, so `wc` prints only the count, not the filename.

## Exercise 3: Separate errors from normal output

Run:

```sh
find missing-directory -type f > out/find-output.txt 2> out/find-errors.txt
echo $?
cat out/find-errors.txt
```

This command intentionally fails because `missing-directory` does not exist. That makes it useful for seeing stderr and exit status.

## Exercise 4: Save and view at the same time

Run:

```sh
grep -h 'status=failed' logs/*.log | tee out/failed-lines.txt | wc -l
```

Pipeline meaning:

- `grep` prints failed log lines.
- `tee` saves a copy to `out/failed-lines.txt`.
- `wc -l` counts the same lines.

## Challenge

Create `out/warn-and-error-counts.txt` with one line for `WARN` and one line for `ERROR`.

## When it goes wrong

- If a file is empty, check whether the command wrote stdout or stderr.
- If you meant to keep old output but used `>`, you overwrote the file. Use `>>` when appending is intended.
- If `echo $?` prints `0` after you ran another command, you waited too long; `$?` only remembers the immediately previous command.

## Check yourself

From the repository root:

```sh
./checks/check-07-pipes-redirection-streams.sh
```

## Next lesson

Next you will build simple summaries with `sort`, `uniq`, `wc`, `cut`, and `tr`.
