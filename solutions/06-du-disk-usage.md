# Solutions 06: du: disk usage

## Exercise 1

Task: Summarize the sandbox.

```sh
du -sh . > out/sandbox-size.txt
```

Why this works: `-s` summarizes and `-h` uses human-readable units.

## Exercise 2

Task: Show top-level directory sizes.

GNU/Linux:

```sh
du -h --max-depth=1 . | sort -h > out/top-level-sizes.txt
```

macOS:

```sh
du -h -d 1 . | sort -h > out/top-level-sizes.txt
```

Common mistake: using `--max-depth` on macOS.

## Exercise 3

Task: Find biggest log paths.

```sh
du -ah logs | sort -h | tail -n 5 > out/biggest-log-paths.txt
```

Why this works: `du -a` includes files and directories.

## Exercise 4

Task: Compare report and log storage.

```sh
du -sh reports logs > out/report-vs-log-size.txt
```

## Challenge

```sh
du -sh csv json configs reports > out/data-size-summary.txt
```
