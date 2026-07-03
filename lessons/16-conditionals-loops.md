# Lesson 16: Conditionals and loops

## Goal

Use conditionals, `case`, `for` loops, and safe `while read` loops to process files and lines.

## Why this matters

Scripts need to make decisions and repeat work. The hard part is doing that without breaking on spaces, blank lines, or comments.

## Before you start

Run:

```sh
cd sandbox
```

You will use `configs/`, `logs/`, and `messy/`.

## Mental model

There are two different looping problems:

- Loop over a shell-generated list, such as `logs/*.log`.
- Loop over input lines or paths produced by another command.

For arbitrary filenames, prefer null-delimited loops:

```sh
find messy -type f -print0 | while IFS= read -r -d '' file; do
  ...
done
```

## Syntax introduced

```sh
if ...; then ... elif ...; else ...; fi
[[ ... ]]
for file in pattern; do ... done
while IFS= read -r line; do ... done
case "$value" in pattern) ... ;; esac
```

What the pieces mean:

- `if` chooses based on a command's success or failure.
- `for file in logs/*.log` repeats once per matched path.
- `while read` processes input one line at a time.
- `IFS=` prevents trimming leading/trailing whitespace.
- `read -r` prevents backslash escapes from being interpreted.
- `case` is useful for several pattern-based branches.

## Exercise 1: Loop over log files

Run:

```sh
for file in logs/*.log; do
  printf '%s: ' "$file"
  grep -c 'level=ERROR' "$file"
done > out/errors-per-log.txt
cat out/errors-per-log.txt
```

What to notice:

- `file` is a variable name chosen by you.
- `"$file"` is quoted every time it is used.
- The whole loop writes to one output file.

## Exercise 2: Skip comments and blank lines

Run:

```sh
while IFS= read -r line; do
  case "$line" in
    ''|\#*) continue ;;
    *) printf '%s\n' "$line" ;;
  esac
done < configs/app.conf > out/app-active-lines.txt
cat out/app-active-lines.txt
```

Pattern meanings:

- `''` matches an empty line.
- `\#*` matches a line starting with `#`.
- `continue` skips to the next loop iteration.

## Exercise 3: Handle filenames with spaces

Run:

```sh
find messy -type f -print0 | while IFS= read -r -d '' file; do
  printf '%s\n' "$file"
done > out/all-messy-files.txt
cat out/all-messy-files.txt
```

This handles paths such as `messy/spaces in names/quarterly draft.txt` as one path.

## Exercise 4: Build a multi-section report

Run:

```sh
{
  printf 'Errors per log\n'
  cat out/errors-per-log.txt
  printf '\nActive app config\n'
  cat out/app-active-lines.txt
} > out/multi-section-report.txt
cat out/multi-section-report.txt
```

The braces group several commands so one redirection writes the whole report.

## Challenge

Add a section listing temporary and backup files.

## When it goes wrong

- If paths with spaces split apart, do not loop over `$(find ...)`; use `find -print0`.
- If comment lines remain, check the `case` patterns.
- If only the last command writes to the file, put the redirection after the closing `}`.

## Compatibility notes

`read -d ''` and `[[ ... ]]` are Bash features. Use Bash for scripts that rely on them.

## Check yourself

Confirm that `out/multi-section-report.txt` has more than one section and paths with spaces remain intact where relevant.

## Next lesson

Next you will organize scripts with functions.
