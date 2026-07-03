# Lesson 05: find: locating files

## Goal

Locate files and directories by name, type, size, modification time, emptiness, and safe command execution.

## Why this matters

Real projects have many files. `find` lets you locate exactly the files you want before acting on them.

## Before you start

```sh
cd sandbox
```

Required files are in `logs/`, `messy/`, and `configs/`.

## Mental model

`find` walks a directory tree and tests each path. Start with `-print` previews before adding actions.

## Commands introduced

- `find . -name`
- `find . -iname`
- `find . -type f`
- `find . -type d`
- `find . -size`
- `find . -mtime`
- `find . -empty`
- `find . -exec`
- `find . -print0`

## Exercise 1: Smallest useful version

Find log files:

```sh
find logs -name '*.log' -type f | sort > out/log-files.txt
cat out/log-files.txt
```

## Exercise 2: Add one option

Find empty files:

```sh
find messy -type f -empty | sort > out/empty-files.txt
cat out/empty-files.txt
```

## Exercise 3: Combine with previous knowledge

Preview temporary and backup files:

```sh
find messy -type f \( -name '*.tmp' -o -name '*.bak' -o -name '*~' \) -print | sort > out/cleanup-preview.txt
cat out/cleanup-preview.txt
```

## Exercise 4: Realistic task

Find config files that mention the deprecated database host:

```sh
find configs -type f -exec grep -l 'old-db.internal' {} \; | sort > out/find-deprecated-configs.txt
cat out/find-deprecated-configs.txt
```

## Challenge

Find directories under `messy/` and save them to `out/messy-directories.txt`.

## Common mistakes

- Forgetting to quote `*.log`, which lets the shell expand it too early.
- Adding delete actions before previewing with `-print`.
- Forgetting to escape parentheses as `\(` and `\)` in many shells.

## GNU/Linux vs macOS notes

`find -size` units and some predicates vary. `-name`, `-type`, `-empty`, `-exec`, and `-print0` are safe for these exercises on GNU/Linux and macOS.

## Bash vs zsh notes

Quote find patterns in both shells. zsh is stricter about unmatched globs.

## Check yourself

From the repository root:

```sh
./checks/check-05-find-locating-files.sh
```

## Next lesson

Next you will summarize disk usage with `du`.
