# Lesson 10: awk: structured text

## Goal

Use `awk` to print fields, filter rows, sum numeric columns, calculate averages, group rows, and inspect log key-value fields.

## Why this matters

`awk` is a compact tool for turning columns and records into useful summaries.

## Before you start

```sh
cd sandbox
```

Required files are in `csv/` and `logs/`.

## Mental model

`awk` reads records, splits them into fields, runs patterns and actions, and can keep counters or sums until the end.

## Commands introduced

- `awk '{print $1}'`
- `awk -F,`
- `awk '$3 > 100'`
- `awk 'NR > 1'`
- `awk '{sum += $3} END {print sum}'`
- `awk '{count[$1]++} END {for (k in count) print k, count[k]}'`

## Exercise 1: Smallest useful version

Print employee names:

```sh
awk -F, 'NR > 1 {print $2}' csv/employees.csv > out/employee-names.txt
cat out/employee-names.txt
```

## Exercise 2: Add one option

Filter expenses over 100:

```sh
awk -F, 'NR > 1 && $4 > 100 {print $0}' csv/expenses.csv > out/large-expenses.csv
cat out/large-expenses.csv
```

## Exercise 3: Combine with previous knowledge

Sum expenses by department:

```sh
awk -F, 'NR > 1 {sum[$3] += $4} END {for (d in sum) print d, sum[d]}' csv/expenses.csv | sort > out/expenses-by-department.txt
cat out/expenses-by-department.txt
```

## Exercise 4: Realistic task

Average latency from app logs:

```sh
awk '{for (i=1; i<=NF; i++) if ($i ~ /^latency_ms=/) {sub("latency_ms=", "", $i); total += $i; count++}} END {if (count) print total / count}' logs/app-2026-06-01.log > out/average-latency.txt
cat out/average-latency.txt
```

## Challenge

Group errors by service and save the result to `out/errors-by-service.txt`.

## Common mistakes

- Forgetting `-F,` for comma-separated input.
- Comparing headers as data; use `NR > 1`.
- Expecting associative array output order to be sorted. Pipe to `sort`.

## GNU/Linux vs macOS notes

The `awk` features used here work with common `awk` versions on GNU/Linux and macOS.

## Bash vs zsh notes

Quote `awk` programs with single quotes in either shell.

## Check yourself

From the repository root:

```sh
./checks/check-10-awk-structured-text.sh
```

## Next lesson

Next you will batch operations with `xargs`.
