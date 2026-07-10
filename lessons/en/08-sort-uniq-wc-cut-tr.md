# Lesson 08: sort, uniq, wc, cut, and tr

## Goal

Turn lines of text into small reports by sorting, counting, extracting fields, and normalizing text.

## Why this matters

Many practical terminal reports are built from the same pattern:

```text
extract one value -> sort -> count -> sort by count
```

## Before you start

Run:

```sh
cd sandbox
```

You will use `logs/` and `csv/`.

## Mental model

These tools mostly process lines:

- `cut` selects part of each line.
- `tr` changes characters.
- `sort` orders lines.
- `uniq` collapses adjacent repeated lines.
- `wc` counts lines, words, or bytes.

Important: `uniq` only sees neighboring duplicates. Sort before `uniq` when you want a count across the whole input.

## Commands introduced

```sh
sort
sort -n
sort -r
uniq
uniq -c
wc -l
cut -d DELIMITER -f FIELD
tr SET1 SET2
```

Option meanings:

- `sort`: alphabetical sort.
- `sort -n`: numeric sort.
- `sort -r`: reverse order.
- `uniq`: remove adjacent duplicate lines.
- `uniq -c`: prefix each unique line with a count.
- `wc -l`: count lines.
- `cut -d, -f3`: split on comma and print field 3.
- `tr '[:upper:]' '[:lower:]'`: convert uppercase to lowercase.

## Exercise 1: List unique users from logs

Run:

```sh
grep -h -o 'user=[^ ]*' logs/*.log | cut -d= -f2 | sort | uniq > out/users.txt
cat out/users.txt
```

Pipeline meaning:

- `grep -o 'user=[^ ]*'` extracts chunks such as `user=alice`.
- `cut -d= -f2` splits on `=` and keeps the second field, such as `alice`.
- `sort | uniq` creates the unique list.

## Exercise 2: Find duplicate user IDs

Run:

```sh
cut -d, -f1 csv/duplicate-users.csv | tail -n +2 | sort | uniq -d > out/duplicate-user-ids.txt
cat out/duplicate-user-ids.txt
```

What each stage does:

- `cut -d, -f1` prints the first CSV column.
- `tail -n +2` skips the header line.
- `sort` groups equal IDs.
- `uniq -d` prints only IDs that appear more than once.

## Exercise 3: Count status values

Run:

```sh
grep -h -o 'status=[^ ]*' logs/*.log | cut -d= -f2 | sort | uniq -c | sort -nr > out/status-counts.txt
cat out/status-counts.txt
```

The final `sort -nr` means numeric reverse sort, so the largest count appears first.

## Exercise 4: Normalize department names

Run:

```sh
cut -d, -f3 csv/messy-data.csv | tail -n +2 | tr '[:upper:]' '[:lower:]' | sort | uniq -c > out/department-counts.txt
cat out/department-counts.txt
```

This demonstrates why normalization matters: `Engineering` and `engineering` should count together for this report.

## Challenge

Create a frequency table of log services and save it to `out/service-counts.txt`.

## When it goes wrong

- If `uniq -c` gives repeated lines in separate places, you forgot to sort first.
- If your CSV output includes the header as data, add `tail -n +2`.
- If `cut -d,` behaves badly on real-world CSV, the file may contain quoted commas. These training files are simple CSV; robust CSV parsing needs a CSV-aware tool.

## Check yourself

From the repository root:

```sh
./checks/check-08-sort-uniq-wc-cut-tr.sh
```

## Next lesson

Next you will edit streams safely with `sed`.
