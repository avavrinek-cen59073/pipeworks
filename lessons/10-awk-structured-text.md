# Lesson 10: awk: structured text

## Goal

Use `awk` to work with fields, filter rows, sum numbers, calculate averages, group values, and process simple key-value logs.

## Why this matters

`awk` sits between quick text filters and full programming languages. It is excellent for "read rows, inspect fields, produce a summary" tasks.

## Before you start

Run:

```sh
cd sandbox
```

You will use `csv/` and `logs/`.

## Mental model

`awk` reads input one record at a time. By default, one record is one line.

Each line is split into fields:

- `$0` is the whole line.
- `$1` is the first field.
- `$2` is the second field.
- `NR` is the current record number.
- `END { ... }` runs after all input has been read.

For CSV-like files in this course, use `-F,` to split fields on commas.

## Commands introduced

```sh
awk '{print $1}'
awk -F, '{print $2}'
awk -F, '$4 > 100 {print $0}'
awk -F, 'NR > 1 {print $2}'
awk -F, 'NR > 1 {sum += $4} END {print sum}'
awk -F, '{count[$1]++} END {for (k in count) print k, count[k]}'
```

Program pieces:

- `pattern { action }`: run `action` only when `pattern` is true.
- `{ action }`: run action for every line.
- `sum += $4`: add field 4 to a running total.
- `count[$1]++`: increment a counter for the value of field 1.

## Exercise 1: Print one field

Run:

```sh
awk -F, 'NR > 1 {print $2}' csv/employees.csv > out/employee-names.txt
cat out/employee-names.txt
```

What it means:

- `-F,` sets the field separator to comma.
- `NR > 1` skips the header row.
- `{print $2}` prints the second field: employee name.

## Exercise 2: Filter rows by a number

Run:

```sh
awk -F, 'NR > 1 && $4 > 100 {print $0}' csv/expenses.csv > out/large-expenses.csv
cat out/large-expenses.csv
```

What it means:

- `&&` means AND.
- `$4 > 100` keeps rows where the amount column is greater than 100.
- `$0` prints the whole row.

## Exercise 3: Sum expenses by department

Run:

```sh
awk -F, 'NR > 1 {sum[$3] += $4} END {for (d in sum) print d, sum[d]}' csv/expenses.csv | sort > out/expenses-by-department.txt
cat out/expenses-by-department.txt
```

What it means:

- `sum[$3]` stores a separate total for each department.
- `END` prints totals after all rows have been read.
- `sort` makes the output predictable.

## Exercise 4: Average latency from logs

Run:

```sh
awk '{for (i=1; i<=NF; i++) if ($i ~ /^latency_ms=/) {sub("latency_ms=", "", $i); total += $i; count++}} END {if (count) print total / count}' logs/app-2026-06-01.log > out/average-latency.txt
cat out/average-latency.txt
```

This is denser. Read it in parts:

- `for (i=1; i<=NF; i++)` loops over every field on the line.
- `$i ~ /^latency_ms=/` finds the field that starts with `latency_ms=`.
- `sub("latency_ms=", "", $i)` removes the key, leaving only the number.
- `total += $i; count++` tracks sum and count.
- `END` prints the average.

## Challenge

Group error log lines by service and save the result to `out/errors-by-service.txt`.

## When it goes wrong

- If fields are wrong, check the separator. CSV examples need `-F,`; log examples use spaces.
- If the header appears in numeric results, add `NR > 1`.
- If grouped output changes order between runs, pipe it to `sort`.

## Check yourself

From the repository root:

```sh
./checks/check-10-awk-structured-text.sh
```

## Next lesson

Next you will batch operations with `xargs`.
