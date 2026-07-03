# Lesson 04: grep: searching text

## Goal

Search text files by exact text, case-insensitive text, inverted matches, recursive search, regular expressions, extracted matches, counts, and matching filenames.

## Why this matters

`grep` is the fastest way to answer common questions about logs and configs: what failed, where a value appears, and how often it happened.

## Before you start

```sh
cd sandbox
```

Required files are in `logs/` and `configs/`.

## Mental model

`grep` reads lines and prints lines that match. Options change what counts as a match or what gets printed.

## Commands introduced

- `grep`
- `grep -i`
- `grep -n`
- `grep -v`
- `grep -r`
- `grep -E`
- `grep -o`
- `grep -c`
- `grep -l`

## Exercise 1: Smallest useful version

Find error lines:

```sh
grep -h 'level=ERROR' logs/*.log > out/errors.txt
```

## Exercise 2: Add one option

Search case-insensitively for failed events:

```sh
grep -hi 'failed' logs/*.log > out/failed-events.txt
```

Show line numbers in one log:

```sh
grep -n 'failed' logs/auth.log
```

## Exercise 3: Combine with previous knowledge

Extract error codes and count them:

```sh
grep -h -o 'code=E[0-9][0-9]*' logs/*.log | sort | uniq -c > out/error-codes.txt
cat out/error-codes.txt
```

## Exercise 4: Realistic task

List config files containing a deprecated host:

```sh
grep -R -l 'old-db.internal' configs > out/deprecated-files.txt
cat out/deprecated-files.txt
```

## Challenge

Find all log lines that are not `INFO`, then save them to `out/not-info.log`.

## Common mistakes

- Forgetting quotes around patterns that contain shell metacharacters.
- Using `grep -r` from too high in the filesystem.
- Expecting `grep -c` to count every match; it counts matching lines per file.

## GNU/Linux vs macOS notes

Avoid `grep -P` for this course. Use `grep -E` for extended regular expressions that work on GNU/Linux and macOS.

## Bash vs zsh notes

This lesson works the same in Bash and zsh because `grep`, `sort`, and `uniq` are external commands.

## Check yourself

From the repository root:

```sh
./checks/check-04-grep-searching-text.sh
```

## Next lesson

Next you will locate files with `find`.
