# Solutions 11: xargs and batch operations

## Exercise 1

Task: Preview commands.

```sh
find messy -name '*.txt' -type f | xargs -n 1 echo inspect
```

Why this works: `xargs -n 1` runs one item per command line.

## Exercise 2

Task: Search found config files.

```sh
find configs -type f -print0 | xargs -0 grep -l 'old-db.internal' > out/xargs-deprecated-configs.txt
```

Why this works: null delimiters handle unusual filenames.

## Exercise 3

Task: Create a safe delete preview.

```sh
find messy -type f \( -name '*.tmp' -o -name '*.bak' -o -name '*~' \) -print0 | xargs -0 -I {} echo rm "{}" > out/xargs-delete-preview.txt
```

Common mistake: removing `echo` before reviewing the output.

## Exercise 4

Task: Copy paths with spaces.

```sh
mkdir -p out/copied-messy
find "messy/spaces in names" -type f -print0 | xargs -0 -I {} cp "{}" out/copied-messy/
```

## Challenge

```sh
find logs -type f -name '*.log' -print0 | xargs -0 wc -l > out/log-line-counts-xargs.txt
```
