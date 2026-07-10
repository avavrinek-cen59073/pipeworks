# Lesson 12: Archives and compression

## Goal

Create, list, extract, and compress archives with `tar`, `gzip`, and optional `zip`.

## Why this matters

Archives are how directories become single files for backups, transfers, releases, and log bundles. Listing before extracting prevents surprises.

## Before you start

Run:

```sh
cd sandbox
```

You will use `reports/`, `logs/`, and `archives/`.

## Mental model

Archive and compression are separate ideas:

- An archive groups files together.
- Compression makes data smaller.

A `.tar` file is an archive. A `.tar.gz` file is usually a tar archive compressed with gzip.

## Commands introduced

```sh
tar -cf ARCHIVE PATH
tar -tf ARCHIVE
tar -xf ARCHIVE
tar -czf ARCHIVE PATH
tar -xzf ARCHIVE
gzip FILE
gunzip FILE.gz
zip
unzip
```

Option meanings:

- `tar -c`: create an archive.
- `tar -t`: list archive contents.
- `tar -x`: extract archive contents.
- `tar -f FILE`: use this archive filename.
- `tar -z`: use gzip compression.
- `gzip FILE`: replace `FILE` with `FILE.gz`.
- `gunzip FILE.gz`: restore the compressed file.

## Exercise 1: Create an archive

Run:

```sh
tar -cf out/reports.tar reports
ls -l out/reports.tar
```

What it means:

- `-c` creates.
- `-f out/reports.tar` names the archive file.
- `reports` is the directory being archived.

## Exercise 2: List before extracting

Run:

```sh
tar -tf out/reports.tar > out/reports-archive-list.txt
cat out/reports-archive-list.txt
```

Listing tells you what paths the archive contains. This matters because extraction recreates those paths.

## Exercise 3: Extract into a target directory

Run:

```sh
mkdir -p out/extracted-reports
tar -xf out/reports.tar -C out/extracted-reports
find out/extracted-reports -type f | sort
```

What `-C` does: it changes to the target directory before extraction. Without it, files extract into your current directory.

## Exercise 4: Create a compressed archive

Run:

```sh
tar -czf out/logs.tar.gz logs
tar -tzf out/logs.tar.gz | head
```

The added `z` means gzip compression. The list command also needs `z` because the archive is compressed.

## Challenge

Copy `reports/incident-001.txt` to `out/`, compress the copy with `gzip`, then restore it with `gunzip`.

## When it goes wrong

- If extraction puts files in the wrong place, you probably omitted `-C`.
- If `tar -tf` cannot read a `.tar.gz`, use `tar -tzf`.
- If `gzip` makes the original filename disappear, that is normal: it replaces `file` with `file.gz`.

## Compatibility notes

The `tar` flags used here work on GNU/Linux and macOS. `zip` and `unzip` are optional in this course because they may not be installed everywhere.

## Check yourself

From the repository root:

```sh
./checks/check-12-archives-compression.sh
```

## Next lesson

Next you will inspect processes and basic system information.
