# Lesson 04: grep: searching text

## Goal

Use `grep` to find matching lines, ignore case, show line numbers, invert matches, search directories, extract matching text, count matches, and list matching files.

## Why this matters

When you inspect logs or configs, you usually start with questions like "where did this fail?", "which files mention this host?", or "how often does this code appear?"

## Before you start

Run:

```sh
cd sandbox
```

You will use `logs/` and `configs/`.

## Mental model

`grep PATTERN FILE...` reads lines and prints the lines that match `PATTERN`.

Default behavior:

- Input is checked one line at a time.
- A line is printed if it contains the pattern.
- With multiple files, `grep` usually prefixes matches with filenames.

## Commands introduced

```sh
grep PATTERN FILE
grep -i PATTERN FILE
grep -n PATTERN FILE
grep -v PATTERN FILE
grep -R PATTERN DIR
grep -E PATTERN FILE
grep -o PATTERN FILE
grep -c PATTERN FILE
grep -l PATTERN FILE
```

Option meanings:

- `-i`: ignore case.
- `-n`: show line numbers.
- `-v`: invert the match; print lines that do not match.
- `-R`: search recursively through a directory.
- `-E`: use extended regular expressions.
- `-o`: print only the matched part, not the whole line.
- `-c`: print a count of matching lines.
- `-l`: print filenames that contain at least one match.
- `-h`: suppress filename prefixes when searching multiple files.

## Exercise 1: Find error lines

Run:

```sh
grep -h 'level=ERROR' logs/*.log > out/errors.txt
cat out/errors.txt
```

Read it left to right:

- `grep` searches.
- `-h` hides filenames so the output contains only log lines.
- `'level=ERROR'` is the pattern.
- `logs/*.log` searches top-level log files.
- `>` saves matches to `out/errors.txt`.

## Exercise 2: Add case-insensitive search and line numbers

Run:

```sh
grep -hi 'failed' logs/*.log > out/failed-events.txt
grep -n 'failed' logs/auth.log
```

What changed:

- `-hi` combines `-h` and `-i`: hide filenames and ignore case.
- `-n` shows where each match appears in one file.

## Exercise 3: Extract and count error codes

Run:

```sh
grep -h -o 'code=E[0-9][0-9]*' logs/*.log | sort | uniq -c > out/error-codes.txt
cat out/error-codes.txt
```

The pattern means:

- `code=E` matches literal text.
- `[0-9]` matches one digit.
- `[0-9]*` matches zero or more additional digits.

The pipeline means:

- `grep -o` prints only codes such as `code=E42`.
- `sort` groups identical codes next to each other.
- `uniq -c` counts adjacent repeated lines.

## Exercise 4: List config files containing a deprecated host

Run:

```sh
grep -R -l 'old-db.internal' configs > out/deprecated-files.txt
cat out/deprecated-files.txt
```

What to notice:

- `-R` searches inside `configs/` and its subdirectories.
- `-l` prints only filenames, which is useful when you plan a later edit.

## Challenge

Find all top-level log lines that are not `INFO`, then save them to `out/not-info.log`.

Hint: use `-v`.

## When it goes wrong

- If you forget quotes around a pattern containing `*`, `[`, or spaces, the shell may interpret it before `grep` sees it.
- If `grep -c` prints one count per file, that is normal. It counts matching lines for each input file.
- If recursive search returns too much, search a narrower directory first.

## Compatibility notes

Avoid `grep -P` in this course. It is GNU-specific and is not available in the default macOS `grep`. Use `grep -E` for the regular expressions taught here.

## Check yourself

From the repository root:

```sh
./checks/check-04-grep-searching-text.sh
```

## Next lesson

Next you will locate files with `find`.
