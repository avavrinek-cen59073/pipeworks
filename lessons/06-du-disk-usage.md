# Lesson 06: du: disk usage

## Goal

Use `du` to answer "how much space does this use?" for files and directories.

## Why this matters

When a machine or project runs out of space, you need a calm way to narrow the problem: first the whole directory, then top-level directories, then individual files.

## Before you start

Run:

```sh
cd sandbox
```

## Mental model

`du` reports disk usage: how much filesystem space paths consume. That is related to file size, but not always identical because filesystems allocate space in blocks.

Start broad, then narrow:

```text
all sandbox -> top-level directories -> files in one directory
```

## Commands introduced

```sh
du -sh PATH
du -h PATH
du -a PATH
du --max-depth=1 PATH
du -d 1 PATH
sort -h
```

Option meanings:

- `-s`: summarize each argument instead of listing every child.
- `-h`: human-readable units such as `K`, `M`, or `G`.
- `-a`: include files as well as directories.
- `--max-depth=1`: GNU/Linux option for one level below the start path.
- `-d 1`: macOS/BSD option for one level below the start path.
- `sort -h`: sort human-readable sizes.

## Exercise 1: Size the sandbox

Run:

```sh
du -sh . > out/sandbox-size.txt
cat out/sandbox-size.txt
```

What each part does:

- `.` means the current directory: `sandbox`.
- `-s` gives one summary line.
- `-h` makes the size readable for humans.

## Exercise 2: Compare top-level directories

Use the command for your system.

GNU/Linux:

```sh
du -h --max-depth=1 . | sort -h > out/top-level-sizes.txt
```

macOS:

```sh
du -h -d 1 . | sort -h > out/top-level-sizes.txt
```

Then inspect:

```sh
cat out/top-level-sizes.txt
```

The important idea is not the exact size. It is learning which directory is larger than the others.

## Exercise 3: Find the largest log paths

Run:

```sh
du -ah logs | sort -h | tail -n 5 > out/biggest-log-paths.txt
cat out/biggest-log-paths.txt
```

Pipeline meaning:

- `du -ah logs` prints sizes for files and directories under `logs`.
- `sort -h` sorts from smallest to largest.
- `tail -n 5` keeps the five largest lines.

## Exercise 4: Compare two areas

Run:

```sh
du -sh reports logs > out/report-vs-log-size.txt
cat out/report-vs-log-size.txt
```

Here `du` receives two arguments: `reports` and `logs`. It prints one summary per argument.

## Challenge

Create `out/data-size-summary.txt` with sizes for `csv`, `json`, `configs`, and `reports`.

## When it goes wrong

- If `--max-depth` fails on macOS, use `-d 1`.
- If `sort -h` is unavailable on an older system, sort without `-h` and treat it as approximate for this lesson.
- If the sizes are tiny, that is fine. The sandbox is intentionally small; the workflow matters.

## Compatibility notes

`du` is one of the commands where GNU/Linux and macOS differ. This lesson shows both top-level-depth variants because both are common in real work.

## Check yourself

Confirm that `out/top-level-sizes.txt` contains several sandbox directories.

## Next lesson

Next you will connect commands with pipes and redirection.
