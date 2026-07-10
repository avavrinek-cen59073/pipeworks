# Lesson 05: find: locating files

## Goal

Use `find` to locate files and directories by name, type, emptiness, size, age, and content-related follow-up commands.

## Why this matters

`grep` finds text inside files. `find` finds paths. Many real tasks need both: first locate the files, then inspect or process them.

## Before you start

Run:

```sh
cd sandbox
```

You will use `logs/`, `messy/`, and `configs/`.

## Mental model

`find START TESTS ACTIONS` walks a directory tree.

Example:

```sh
find logs -name '*.log' -type f -print
```

- `logs` is where the walk starts.
- `-name '*.log'` keeps paths whose names match the pattern.
- `-type f` keeps regular files.
- `-print` prints matching paths.

If you omit an action, many `find` versions print by default, but writing `-print` makes your intent clear.

## Commands introduced

```sh
find . -name PATTERN
find . -iname PATTERN
find . -type f
find . -type d
find . -size SIZE
find . -mtime DAYS
find . -empty
find . -exec COMMAND {} \;
find . -print0
```

Option meanings:

- `-name`: match a filename pattern exactly as written.
- `-iname`: match a filename pattern case-insensitively.
- `-type f`: regular files only.
- `-type d`: directories only.
- `-size`: match file size.
- `-mtime`: match modification time in days.
- `-empty`: empty files or empty directories.
- `-exec ... {} \;`: run a command for each matched path; `{}` is replaced by the path.
- `-print0`: print paths separated by a null byte for safe use with `xargs -0`.

## Exercise 1: Find log files

Run:

```sh
find logs -name '*.log' -type f -print | sort > out/log-files.txt
cat out/log-files.txt
```

Why the quotes matter: `'*.log'` must be passed to `find`. If you write `*.log` unquoted, the shell may expand it before `find` runs.

## Exercise 2: Find empty files

Run:

```sh
find messy -type f -empty -print | sort > out/empty-files.txt
cat out/empty-files.txt
```

This finds files that contain zero bytes. A file with a blank-looking line is not empty; it contains a newline.

## Exercise 3: Preview cleanup candidates

Run:

```sh
find messy -type f \( -name '*.tmp' -o -name '*.bak' -o -name '*~' \) -print | sort > out/cleanup-preview.txt
cat out/cleanup-preview.txt
```

What the expression means:

- `\(` and `\)` group the name tests. The backslashes stop the shell from treating parentheses specially.
- `-o` means OR.
- The command prints candidates only; it does not delete them.

## Exercise 4: Combine `find` with `grep`

Run:

```sh
find configs -type f -exec grep -l 'old-db.internal' {} \; | sort > out/find-deprecated-configs.txt
cat out/find-deprecated-configs.txt
```

What each special piece means:

- `-exec grep -l ... {} \;` runs `grep -l` once per found file.
- `{}` is replaced with the current path.
- `\;` marks the end of the command passed to `-exec`.

## Challenge

Find directories under `messy/` and save them to `out/messy-directories.txt`.

## When it goes wrong

- If `find` returns nothing, check the start directory first: `find messy -maxdepth 1 -print`.
- If parentheses cause a shell error, make sure they are escaped as `\(` and `\)`.
- If filenames with spaces break a later command, use `find ... -print0` and a tool that understands null-delimited input.

## Compatibility notes

The tests used in the exercises work on GNU/Linux and macOS. Some advanced `-size`, `-mtime`, and `-printf` examples found online are not portable; check your local `man find`.

## Check yourself

From the repository root:

```sh
./checks/check-05-find-locating-files.sh
```

## Next lesson

Next you will summarize disk usage with `du`.
