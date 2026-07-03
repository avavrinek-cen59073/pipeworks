# Lesson 08: sort, uniq, wc, cut, and tr

## Goal

Sort data, count repeated values, count lines, extract fields, and normalize simple text.

## Why this matters

Many useful reports are built from selecting one field, sorting it, counting it, and formatting the result.

## Before you start

```sh
cd sandbox
```

Required files are in `logs/` and `csv/`.

## Mental model

`uniq` only combines adjacent duplicates, so sort before `uniq` when counting all repeated values.

## Commands introduced

- `sort`
- `sort -n`
- `sort -r`
- `uniq`
- `uniq -c`
- `wc -l`
- `cut -d`
- `cut -f`
- `tr`

## Exercise 1: Smallest useful version

List unique users from logs:

```sh
grep -h -o 'user=[^ ]*' logs/*.log | cut -d= -f2 | sort | uniq > out/users.txt
cat out/users.txt
```

## Exercise 2: Add one option

Find duplicate user IDs in a CSV:

```sh
cut -d, -f1 csv/duplicate-users.csv | tail -n +2 | sort | uniq -d > out/duplicate-user-ids.txt
cat out/duplicate-user-ids.txt
```

## Exercise 3: Combine with previous knowledge

Count status values:

```sh
grep -h -o 'status=[^ ]*' logs/*.log | cut -d= -f2 | sort | uniq -c | sort -nr > out/status-counts.txt
cat out/status-counts.txt
```

## Exercise 4: Realistic task

Normalize department names from messy CSV data:

```sh
cut -d, -f3 csv/messy-data.csv | tail -n +2 | tr '[:upper:]' '[:lower:]' | sort | uniq -c > out/department-counts.txt
cat out/department-counts.txt
```

## Challenge

Create a frequency table of log services and save it to `out/service-counts.txt`.

## Common mistakes

- Running `uniq -c` before sorting.
- Forgetting to remove CSV headers.
- Using `cut -d,` on complex CSV with quoted commas. These training CSV files avoid quoted commas.

## GNU/Linux vs macOS notes

`sort -h` is common but not POSIX. This lesson uses plain `sort`, `sort -n`, and `sort -r`.

## Bash vs zsh notes

These commands work the same in Bash and zsh.

## Check yourself

From the repository root:

```sh
./checks/check-08-sort-uniq-wc-cut-tr.sh
```

## Next lesson

Next you will edit streams safely with `sed`.
