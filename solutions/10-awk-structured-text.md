# Solutions 10: awk: structured text

## Exercise 1

Task: Print employee names.

```sh
awk -F, 'NR > 1 {print $2}' csv/employees.csv > out/employee-names.txt
```

Why this works: `-F,` sets comma as the field separator and `NR > 1` skips the header.

## Exercise 2

Task: Filter large expenses.

```sh
awk -F, 'NR > 1 && $4 > 100 {print $0}' csv/expenses.csv > out/large-expenses.csv
```

Why this works: `$4` is the amount column.

## Exercise 3

Task: Sum expenses by department.

```sh
awk -F, 'NR > 1 {sum[$3] += $4} END {for (d in sum) print d, sum[d]}' csv/expenses.csv | sort > out/expenses-by-department.txt
```

Why this works: `sum[$3]` keeps one running total per department.

## Exercise 4

Task: Average latency.

```sh
awk '{for (i=1; i<=NF; i++) if ($i ~ /^latency_ms=/) {sub("latency_ms=", "", $i); total += $i; count++}} END {if (count) print total / count}' logs/app-2026-06-01.log > out/average-latency.txt
```

## Challenge

```sh
grep -h 'level=ERROR' logs/*.log | awk '{for (i=1; i<=NF; i++) if ($i ~ /^service=/) {sub("service=", "", $i); count[$i]++}} END {for (s in count) print s, count[s]}' | sort > out/errors-by-service.txt
```
