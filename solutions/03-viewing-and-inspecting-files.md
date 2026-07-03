# Solutions 03: Viewing and inspecting files

## Exercise 1

Task: Show a short report.

```sh
cat reports/q1.txt
```

Why this works: `cat` is fine for small files.

## Exercise 2

Task: Show the beginning and end of a log.

```sh
head -n 3 logs/app-2026-06-01.log
tail -n 3 logs/app-2026-06-01.log
```

Alternative: use `less` for interactive inspection.

## Exercise 3

Task: Count lines in logs.

```sh
wc -l logs/*.log > out/log-line-counts.txt
```

Why this works: `wc -l` counts lines and the glob selects top-level log files.

## Exercise 4

Task: Identify file types.

```sh
file reports/q1.txt archives/* > out/file-types.txt
```

Common mistake: expecting identical `file` wording across operating systems.

## Challenge

Open the log and search:

```sh
less logs/auth.log
```

Inside `less`, type `/failed`, press Enter, then press `q` to quit.
