# Solutions 05: find: locating files

## Exercise 1

Task: Find log files.

```sh
find logs -name '*.log' -type f | sort > out/log-files.txt
```

Why this works: quoting `*.log` lets `find` apply the pattern.

## Exercise 2

Task: Find empty files.

```sh
find messy -type f -empty | sort > out/empty-files.txt
```

Why this works: `-type f` excludes directories and `-empty` matches zero-byte files.

## Exercise 3

Task: Preview temp and backup files.

```sh
find messy -type f \( -name '*.tmp' -o -name '*.bak' -o -name '*~' \) -print | sort > out/cleanup-preview.txt
```

Why this works: parentheses group the name tests; `-print` previews paths.

## Exercise 4

Task: Find configs containing a deprecated host.

```sh
find configs -type f -exec grep -l 'old-db.internal' {} \; | sort > out/find-deprecated-configs.txt
```

Alternative: `grep -R -l 'old-db.internal' configs`.

## Challenge

```sh
find messy -type d | sort > out/messy-directories.txt
```
