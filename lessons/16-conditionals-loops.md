# Lesson 16: Conditionals and loops

## Goal

Use conditionals, `case`, `for` loops, and safe `while read -r` loops.

## Why this matters

Scripts need to make decisions and process many files or lines without breaking on spaces.

## Before you start

```sh
cd sandbox
```

Required files are in `configs/`, `logs/`, and `messy/`.

## Mental model

Conditionals choose a branch. Loops repeat work. Line-based loops should preserve backslashes and spaces with `IFS= read -r`.

## Commands introduced

- `if`
- `elif`
- `else`
- `[[ ]]`
- `for`
- `while read -r`
- `case`

## Exercise 1: Smallest useful version

Loop over logs:

```sh
for file in logs/*.log; do
  printf '%s: ' "$file"
  grep -c 'level=ERROR' "$file"
done > out/errors-per-log.txt
cat out/errors-per-log.txt
```

## Exercise 2: Add one option

Skip blank and comment lines:

```sh
while IFS= read -r line; do
  case "$line" in
    ''|\#*) continue ;;
    *) printf '%s\n' "$line" ;;
  esac
done < configs/app.conf > out/app-active-lines.txt
```

## Exercise 3: Combine with previous knowledge

Handle files with spaces:

```sh
find messy -type f -print0 | while IFS= read -r -d '' file; do
  printf '%s\n' "$file"
done > out/all-messy-files.txt
```

## Exercise 4: Realistic task

Generate a multi-section report:

```sh
{
  printf 'Errors per log\n'
  cat out/errors-per-log.txt
  printf '\nActive app config\n'
  cat out/app-active-lines.txt
} > out/multi-section-report.txt
```

## Challenge

Add a section listing temporary and backup files.

## Common mistakes

- Looping over `$(find ...)` and breaking filenames with spaces.
- Forgetting to quote `$file`.
- Using `[` when you need Bash-specific `[[ ]]` pattern behavior.

## GNU/Linux vs macOS notes

`read -d ''` is Bash-specific and works with Bash on GNU/Linux and macOS.

## Bash vs zsh notes

This lesson uses Bash syntax. Run scripts with Bash.

## Check yourself

Confirm that `out/multi-section-report.txt` has more than one section and paths with spaces remain intact.

## Next lesson

Next you will organize scripts with functions.
