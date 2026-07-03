# Lesson 11: xargs and batch operations

## Goal

Use `xargs` to turn lists from stdin into command arguments, while handling spaces safely.

## Why this matters

A common workflow is:

```text
find paths -> preview command -> run command on those paths
```

`xargs` helps with the second half, but it must be used carefully with filenames.

## Before you start

Run:

```sh
cd sandbox
```

You will use `messy/` and `configs/`.

## Mental model

`xargs` reads items from stdin and appends them as arguments to another command.

Example:

```sh
printf '%s\n' a b c | xargs echo item:
```

This becomes roughly:

```sh
echo item: a b c
```

For filenames, prefer null-delimited input:

```sh
find . -print0 | xargs -0 ...
```

Newlines and spaces can appear in filenames. Null bytes cannot.

## Commands introduced

```sh
xargs
xargs -n 1
xargs -I {}
find ... -print0 | xargs -0
```

Option meanings:

- `xargs COMMAND`: collect input items and run `COMMAND` with them as arguments.
- `-n 1`: use one input item per command invocation.
- `-I {}`: use `{}` as a placeholder inside the command.
- `-0`: read null-delimited input from `find -print0`.

## Exercise 1: Preview generated commands

Run:

```sh
find messy -name '*.txt' -type f -print | xargs -n 1 echo inspect
```

This prints commands shaped like `inspect PATH`. It does not inspect anything; `echo` is the dry run.

This simple version is intentionally not safe for paths with spaces. You will fix that pattern in later exercises.

## Exercise 2: Search found files safely

Run:

```sh
find configs -type f -print0 | xargs -0 grep -l 'old-db.internal' > out/xargs-deprecated-configs.txt
cat out/xargs-deprecated-configs.txt
```

What changed:

- `find ... -print0` separates paths with null bytes.
- `xargs -0` reads that format.
- `grep -l` prints filenames that contain the deprecated host.

## Exercise 3: Create a safe delete preview

Run:

```sh
find messy -type f \( -name '*.tmp' -o -name '*.bak' -o -name '*~' \) -print0 | xargs -0 -I {} echo rm "{}" > out/xargs-delete-preview.txt
cat out/xargs-delete-preview.txt
```

This creates a deletion plan, not a deletion. `echo rm "{}"` prints what would be run.

## Exercise 4: Copy files whose paths contain spaces

Run:

```sh
mkdir -p out/copied-messy
find "messy/spaces in names" -type f -print0 | xargs -0 -I {} cp "{}" out/copied-messy/
ls out/copied-messy
```

Why this works:

- The start path is quoted.
- `-print0` and `-0` preserve filenames with spaces.
- `-I {}` lets you place the source path before the destination.

## Challenge

Use `find -print0` and `xargs -0` to run `wc -l` on every log file.

## When it goes wrong

- If a filename with spaces is split into pieces, switch to `find -print0 | xargs -0`.
- If your preview says `rm` against files you did not expect, stop. Fix the `find` expression before removing anything.
- If `xargs` runs the command with no input, check your `find` expression first.

## Compatibility notes

`find -print0` and `xargs -0` are available on GNU/Linux and macOS and are the safe default for filenames.

## Check yourself

From the repository root:

```sh
./checks/check-11-xargs-batch-operations.sh
```

## Next lesson

Next you will create, list, extract, and compress archives.
