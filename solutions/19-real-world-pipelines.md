# Solutions 19: Real-world pipelines

## Exercise 1

Task: Create a failure report.

```sh
grep -h 'status=failed' logs/*.log \
  | sed -E 's/.*user=([^ ]+).*code=([^ ]+).*/user=\1 code=\2/' \
  | sort \
  | uniq -c \
  | sort -nr > out/failure-report.txt
```

Why this works: the pipeline filters, extracts fields, counts repeated pairs, and sorts by frequency.

## Exercise 2

Task: Create a config audit.

```sh
grep -R -n 'old-db.internal' configs > out/config-audit.txt
```

Why this works: recursive grep reports file and line numbers.

## Exercise 3

Task: Detect duplicate CSV users.

```sh
cut -d, -f1 csv/duplicate-users.csv | tail -n +2 | sort | uniq -d > out/duplicate-users-report.txt
```

## Exercise 4

Task: Generate a cleanup plan.

```sh
find messy -type f \( -name '*.tmp' -o -name '*.bak' -o -name '*~' \) -print | sort > out/cleanup-plan.txt
```

Common mistake: deleting files instead of writing a plan.

## Challenge

A readable incident report can be built with grouped commands:

```sh
{
  printf '# Incident report\n\n'
  printf '## Top failed users\n'
  grep -h 'status=failed' logs/*.log | grep -o 'user=[^ ]*' | cut -d= -f2 | sort | uniq -c | sort -nr
  printf '\n## Unique error codes\n'
  grep -h -o 'code=E[0-9][0-9]*' logs/*.log | sort | uniq
} > out/incident-report.md
```

Add the IP, timestamp, and service sections with the same pattern.
