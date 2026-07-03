# Lesson 03: Viewing and inspecting files

## Goal

Inspect text files, count lines, view only part of a file, and identify file types before processing them.

## Why this matters

Good terminal work starts with inspection. Before searching, editing, or archiving a file, first learn what is inside and how large it is.

## Before you start

Run:

```sh
cd sandbox
```

You will use `logs/`, `reports/`, and `archives/`.

## Mental model

Inspection commands should not change files. Use them to answer:

- Is this file text?
- Is it short enough to print?
- How many lines does it have?
- What does the beginning or end look like?

## Commands introduced

```sh
cat
less
head
tail
wc
file
```

Command anatomy:

- `cat FILE`: print the whole file. Best for short files.
- `less FILE`: open a scrollable viewer. Press `q` to quit.
- `head -n N FILE`: print the first `N` lines.
- `tail -n N FILE`: print the last `N` lines.
- `wc -l FILE`: count lines. `-l` means lines.
- `file PATH`: guess what kind of file a path contains.

## Exercise 1: Print a short file

Run:

```sh
cat reports/q1.txt
```

This file is short, so `cat` is reasonable. Do not use `cat` blindly on files you have not inspected; some logs are thousands or millions of lines.

## Exercise 2: Read only the beginning and end

Run:

```sh
head -n 3 logs/app-2026-06-01.log
tail -n 3 logs/app-2026-06-01.log
```

What each part does:

- `-n 3` means "show 3 lines".
- `head` answers "what does this file start with?"
- `tail` answers "what happened most recently in this file?"

## Exercise 3: Count log lines

Run:

```sh
wc -l logs/*.log > out/log-line-counts.txt
cat out/log-line-counts.txt
```

What to notice:

- `logs/*.log` matches top-level log files in `logs/`.
- `wc -l` prints line counts.
- Because more than one file is passed, `wc` also prints a `total` line.

## Exercise 4: Identify file types

Run:

```sh
file reports/q1.txt archives/* > out/file-types.txt
cat out/file-types.txt
```

`file` helps you avoid treating an archive as plain text. The exact wording can differ by system, but you should be able to tell text from archive data.

## Challenge

Open `logs/auth.log` with `less`, search for `failed`, move to the next match, and quit.

Hints inside `less`:

- `/failed` searches forward.
- `n` goes to the next match.
- `q` quits.

## When it goes wrong

- If your terminal fills with too much text, use `less`, `head`, or `tail` instead of `cat`.
- If `archives/*` prints the literal pattern, the archives may not exist. Run `../tools/make-archives.sh` from the repository root, then reset the sandbox.
- If `wc -l` output surprises you, remember it counts newline-terminated lines, not "records" in every possible format.

## Check yourself

Confirm these files exist and contain readable output:

```sh
out/log-line-counts.txt
out/file-types.txt
```

## Next lesson

Next you will search text with `grep`.
