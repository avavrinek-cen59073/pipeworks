# Lesson 12: Archives and compression

## Goal

Create, list, extract, and compress archives with `tar`, `gzip`, and optional `zip`.

## Why this matters

Archives are common for backups, logs, releases, and transferring groups of files safely.

## Before you start

```sh
cd sandbox
```

Required files are in `reports/` and `archives/`.

## Mental model

An archive groups files. Compression makes bytes smaller. `.tar.gz` usually means a tar archive compressed with gzip.

## Commands introduced

- `tar -cf`
- `tar -tf`
- `tar -xf`
- `tar -czf`
- `tar -xzf`
- `gzip`
- `gunzip`
- optional: `zip`, `unzip`

## Exercise 1: Smallest useful version

Create a tar archive of reports:

```sh
tar -cf out/reports.tar reports
```

## Exercise 2: Add one option

List archive contents:

```sh
tar -tf out/reports.tar > out/reports-archive-list.txt
cat out/reports-archive-list.txt
```

## Exercise 3: Combine with previous knowledge

Extract into a target directory:

```sh
mkdir -p out/extracted-reports
tar -xf out/reports.tar -C out/extracted-reports
find out/extracted-reports -type f | sort
```

## Exercise 4: Realistic task

Create a compressed log archive:

```sh
tar -czf out/logs.tar.gz logs
tar -tzf out/logs.tar.gz | head
```

## Challenge

Compress `reports/incident-001.txt` with `gzip`, then restore it with `gunzip`. Work on a copy under `out/`.

## Common mistakes

- Extracting into the current directory without checking archive contents.
- Forgetting `-C` when you want a specific extraction target.
- Confusing `tar -tf` for listing with `tar -xf` for extracting.

## GNU/Linux vs macOS notes

The `tar` flags in this lesson work on GNU/Linux and macOS.

## Bash vs zsh notes

These external commands work the same in Bash and zsh.

## Check yourself

From the repository root:

```sh
./checks/check-12-archives-compression.sh
```

## Next lesson

Next you will inspect processes and basic system information.
