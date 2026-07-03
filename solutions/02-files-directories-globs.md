# Solutions 02: Files, directories, and globs

## Exercise 1

Task: Create a practice directory and file.

```sh
mkdir -p out/file-practice
touch out/file-practice/empty-note.txt
```

Why this works: `mkdir -p` creates missing parent directories and does not fail if they already exist.

## Exercise 2

Task: Copy text files from `messy/`.

```sh
cp messy/*.txt out/file-practice/
```

Why this works: the shell expands `messy/*.txt` to matching files before `cp` runs.

## Exercise 3

Task: Copy a path with spaces.

```sh
cp "messy/spaces in names/quarterly draft.txt" out/file-practice/
```

Why this works: quotes keep the path as one argument.

## Exercise 4

Task: Preview and remove only one copied file.

```sh
printf '%s\n' out/file-practice/*.txt
rm out/file-practice/empty-note.txt
```

Common mistake: using `rm out/file-practice/*` without checking targets.

## Challenge

```sh
mv "out/file-practice/quarterly draft.txt" out/file-practice/quarterly-draft.txt
```
