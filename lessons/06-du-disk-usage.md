# Lesson 06: du: disk usage

## Goal

Summarize directory and file sizes with `du` and sort the results.

## Why this matters

Disk investigations often begin with one question: what is taking space?

## Before you start

```sh
cd sandbox
```

## Mental model

`du` reports disk usage for paths. Human-readable output is easier for people; numeric output is easier for scripts.

## Commands introduced

- `du -sh`
- `du -h`
- `du -a`
- `du --max-depth=1`
- `du -d 1`
- `sort -h`

## Exercise 1: Smallest useful version

Summarize the whole sandbox:

```sh
du -sh . > out/sandbox-size.txt
cat out/sandbox-size.txt
```

## Exercise 2: Add one option

Show top-level directory sizes.

GNU/Linux:

```sh
du -h --max-depth=1 . | sort -h > out/top-level-sizes.txt
```

macOS:

```sh
du -h -d 1 . | sort -h > out/top-level-sizes.txt
```

## Exercise 3: Combine with previous knowledge

Find the biggest regular-looking paths under `logs/`:

```sh
du -ah logs | sort -h | tail -n 5 > out/biggest-log-paths.txt
cat out/biggest-log-paths.txt
```

## Exercise 4: Realistic task

Compare report and log storage:

```sh
du -sh reports logs > out/report-vs-log-size.txt
cat out/report-vs-log-size.txt
```

## Challenge

Create a one-screen disk summary for `csv`, `json`, `configs`, and `reports`.

## Common mistakes

- Expecting exact byte counts from human-readable output.
- Forgetting that apparent file size and disk usage are not always the same.
- Using GNU-only `--max-depth` on macOS.

## GNU/Linux vs macOS notes

Use `du -h --max-depth=1 .` on GNU/Linux and `du -h -d 1 .` on macOS.

## Bash vs zsh notes

The commands are external and work the same in Bash and zsh.

## Check yourself

Confirm that `out/top-level-sizes.txt` contains several sandbox directories.

## Next lesson

Next you will connect commands with pipes and redirection.
