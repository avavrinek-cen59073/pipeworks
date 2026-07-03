# Solutions 12: Archives and compression

## Exercise 1

Task: Create a tar archive.

```sh
tar -cf out/reports.tar reports
```

Why this works: `-c` creates an archive and `-f` names the output file.

## Exercise 2

Task: List archive contents.

```sh
tar -tf out/reports.tar > out/reports-archive-list.txt
```

Why this works: `-t` lists without extracting.

## Exercise 3

Task: Extract into a target directory.

```sh
mkdir -p out/extracted-reports
tar -xf out/reports.tar -C out/extracted-reports
```

Common mistake: extracting before listing the archive.

## Exercise 4

Task: Create a compressed log archive.

```sh
tar -czf out/logs.tar.gz logs
tar -tzf out/logs.tar.gz | head
```

## Challenge

```sh
cp reports/incident-001.txt out/incident-001.txt
gzip out/incident-001.txt
gunzip out/incident-001.txt.gz
```
