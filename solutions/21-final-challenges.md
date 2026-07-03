# Solutions 21: Final challenges

## Exercise 1

Task: Log investigation.

Useful command shapes:

```sh
grep -h 'status=failed' logs/*.log | grep -o 'user=[^ ]*' | cut -d= -f2 | sort | uniq -c | sort -nr
grep -h 'status=failed' logs/*.log | grep -o 'ip=[^ ]*' | cut -d= -f2 | sort | uniq -c | sort -nr
grep -h -o 'code=E[0-9][0-9]*' logs/*.log | sort | uniq
```

Why this works: each pipeline answers one clear question.

## Exercise 2

Task: Config migration.

```sh
mkdir -p out/final/migrated-configs
grep -R -l 'old-db.internal' configs | while IFS= read -r file; do
  cp "$file" "out/final/migrated-configs/${file##*/}"
done
sed -i.bak 's/old-db.internal/db.internal.local/g' out/final/migrated-configs/*
rm -f out/final/migrated-configs/*.bak
```

On macOS you can also use `sed -i ''` instead of backup files. The backup-file form works on many systems but should be tested.

## Exercise 3

Task: Disk cleanup audit.

```sh
{
  printf '# Cleanup audit\n\n'
  printf '## Largest paths\n'
  du -ah . | sort -h | tail -n 10
  printf '\n## Cleanup candidates\n'
  find messy -type f \( -name '*.tmp' -o -name '*.bak' -o -name '*~' \) -print | sort
} > out/final/cleanup-audit.md
```

## Exercise 4

Task: CSV business report.

```sh
{
  printf '# CSV business report\n\n'
  printf '## Expenses by department\n'
  awk -F, 'NR > 1 {sum[$3] += $4} END {for (d in sum) print d, sum[d]}' csv/expenses.csv | sort
  printf '\n## Duplicate users\n'
  cut -d, -f1 csv/duplicate-users.csv | tail -n +2 | sort | uniq -d
  printf '\n## Missing fields\n'
  awk -F, 'NR > 1 {for (i=1; i<=NF; i++) if ($i == "") print NR ":" $0}' csv/messy-data.csv
} > out/final/csv-business-report.md
```

## Challenge

`out/final/project-audit.sh` should combine the report sections above, validate that it is run from `sandbox/`, create `out/final/`, and write a single Markdown report. Keep cleanup previews non-destructive.
