# Solutions 04: grep: searching text

## Exercise 1

Task: Save error lines.

```sh
grep -h 'level=ERROR' logs/*.log > out/errors.txt
```

Why this works: `grep` keeps matching lines and `-h` hides filenames when multiple files are searched.

## Exercise 2

Task: Search case-insensitively and show line numbers.

```sh
grep -hi 'failed' logs/*.log > out/failed-events.txt
grep -n 'failed' logs/auth.log
```

Why this works: `-i` ignores case and `-n` adds line numbers.

## Exercise 3

Task: Extract and count error codes.

```sh
grep -h -o 'code=E[0-9][0-9]*' logs/*.log | sort | uniq -c > out/error-codes.txt
```

Why this works: `-o` prints only the match; `sort | uniq -c` counts repeated codes.

## Exercise 4

Task: List configs containing a deprecated host.

```sh
grep -R -l 'old-db.internal' configs > out/deprecated-files.txt
```

Why this works: `-R` searches recursively and `-l` prints filenames.

## Challenge

```sh
grep -h -v 'level=INFO' logs/*.log > out/not-info.log
```
