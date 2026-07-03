# Solutions 08: sort, uniq, wc, cut, and tr

## Exercise 1

Task: List unique users.

```sh
grep -h -o 'user=[^ ]*' logs/*.log | cut -d= -f2 | sort | uniq > out/users.txt
```

Why this works: extract the key-value field, cut after `=`, sort, then deduplicate.

## Exercise 2

Task: Find duplicate user IDs.

```sh
cut -d, -f1 csv/duplicate-users.csv | tail -n +2 | sort | uniq -d > out/duplicate-user-ids.txt
```

Why this works: `tail -n +2` skips the header and `uniq -d` prints duplicated adjacent values.

## Exercise 3

Task: Count status values.

```sh
grep -h -o 'status=[^ ]*' logs/*.log | cut -d= -f2 | sort | uniq -c | sort -nr > out/status-counts.txt
```

Common mistake: omitting the first `sort`.

## Exercise 4

Task: Normalize department names.

```sh
cut -d, -f3 csv/messy-data.csv | tail -n +2 | tr '[:upper:]' '[:lower:]' | sort | uniq -c > out/department-counts.txt
```

Alternative: use `awk -F,` to skip rows with missing fields.

## Challenge

```sh
grep -h -o 'service=[^ ]*' logs/*.log | cut -d= -f2 | sort | uniq -c | sort -nr > out/service-counts.txt
```
