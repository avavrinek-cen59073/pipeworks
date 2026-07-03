# Lesson 02: Files, directories, and globs

## Goal

Create, copy, move, and remove files safely while understanding glob expansion and quoted paths.

## Why this matters

Batch file operations are powerful. A small quoting or glob mistake can affect many files.

## Before you start

```sh
cd sandbox
```

Required files are in `messy/`.

## Mental model

The shell expands globs like `*.txt` before the command runs. Quotes protect spaces and prevent unwanted splitting.

## Commands introduced

- `mkdir`
- `touch`
- `cp`
- `mv`
- `rm`
- `printf`

## Exercise 1: Smallest useful version

Create a practice directory:

```sh
mkdir -p out/file-practice
touch out/file-practice/empty-note.txt
```

## Exercise 2: Add one option

Copy text files from `messy/` into your practice directory:

```sh
cp messy/*.txt out/file-practice/
```

List what changed:

```sh
ls out/file-practice
```

## Exercise 3: Combine with previous knowledge

Copy a path with spaces. The quotes matter:

```sh
cp "messy/spaces in names/quarterly draft.txt" out/file-practice/
```

## Exercise 4: Realistic task

Preview files before removing copies:

```sh
printf 'Would remove:\n'
printf '%s\n' out/file-practice/*.txt
```

Then remove only the copied `empty-note.txt`:

```sh
rm out/file-practice/empty-note.txt
```

## Challenge

Move `quarterly draft.txt` inside `out/file-practice/` to `quarterly-draft.txt`.

## Common mistakes

- Running `rm` before listing the targets.
- Forgetting quotes around paths with spaces.
- Thinking `*.txt` searches recursively. It only matches in the current path segment.

## GNU/Linux vs macOS notes

The commands in this lesson are portable.

## Bash vs zsh notes

zsh reports an error for unmatched globs by default. Bash usually passes the unmatched pattern as text.

## Check yourself

Use `ls out/file-practice` and confirm that your copied files are there.

## Next lesson

Next you will inspect file contents without editing them.
