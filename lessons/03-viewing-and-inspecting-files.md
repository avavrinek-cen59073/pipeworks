# Lesson 03: Viewing and inspecting files

## Goal

Inspect files with commands that show whole files, file beginnings, file endings, counts, and file types.

## Why this matters

Before searching or transforming data, you need to know what kind of file you are looking at and how large it is.

## Before you start

```sh
cd sandbox
```

Required files are in `logs/`, `reports/`, and `archives/`.

## Mental model

Inspection commands should not change files. Use them to build confidence before running commands that write or delete.

## Commands introduced

- `cat`
- `less`
- `head`
- `tail`
- `wc`
- `file`

## Exercise 1: Smallest useful version

Show a short report:

```sh
cat reports/q1.txt
```

## Exercise 2: Add one option

Show only the beginning and end of a log:

```sh
head -n 3 logs/app-2026-06-01.log
tail -n 3 logs/app-2026-06-01.log
```

## Exercise 3: Combine with previous knowledge

Count lines in log files:

```sh
wc -l logs/*.log > out/log-line-counts.txt
cat out/log-line-counts.txt
```

## Exercise 4: Realistic task

Identify text files and archive files:

```sh
file reports/q1.txt archives/* > out/file-types.txt
cat out/file-types.txt
```

If archives are missing, run `../tools/make-archives.sh` from the repository root, then reset the sandbox.

## Challenge

Use `less` to open `logs/auth.log`, search inside it for `failed`, then quit.

## Common mistakes

- Using `cat` on very large files instead of `less`, `head`, or `tail`.
- Forgetting that `wc -l logs/*.log` includes a `total` line.
- Expecting `file` to understand every format perfectly.

## GNU/Linux vs macOS notes

The output wording of `file` can differ, but the command is used the same way.

## Bash vs zsh notes

These external commands work the same in Bash and zsh.

## Check yourself

Confirm that `out/log-line-counts.txt` and `out/file-types.txt` exist and contain readable output.

## Next lesson

Next you will search text with `grep`.
