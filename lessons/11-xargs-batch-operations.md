# Lesson 11: xargs and batch operations

## Goal

Use `xargs` for argument lists, batches, placeholders, null-delimited paths, dry runs, and safe deletion previews.

## Why this matters

Many tasks start by finding paths, then running another command on those paths. `xargs` connects those steps.

## Before you start

```sh
cd sandbox
```

Required files are in `messy/` and `configs/`.

## Mental model

`xargs` reads items from stdin and turns them into command arguments. Use `-0` with `find -print0` for filenames that may contain spaces.

## Commands introduced

- `xargs`
- `xargs -n`
- `xargs -I {}`
- `find ... -print0 | xargs -0`

## Exercise 1: Smallest useful version

Preview commands instead of running them:

```sh
find messy -name '*.txt' -type f | xargs -n 1 echo inspect
```

## Exercise 2: Add one option

Search found config files:

```sh
find configs -type f -print0 | xargs -0 grep -l 'old-db.internal' > out/xargs-deprecated-configs.txt
cat out/xargs-deprecated-configs.txt
```

## Exercise 3: Combine with previous knowledge

Create a safe delete preview:

```sh
find messy -type f \( -name '*.tmp' -o -name '*.bak' -o -name '*~' \) -print0 | xargs -0 -I {} echo rm "{}" > out/xargs-delete-preview.txt
cat out/xargs-delete-preview.txt
```

## Exercise 4: Realistic task

Copy selected files into an output directory while preserving spaces:

```sh
mkdir -p out/copied-messy
find "messy/spaces in names" -type f -print0 | xargs -0 -I {} cp "{}" out/copied-messy/
ls out/copied-messy
```

## Challenge

Use `find -print0` and `xargs -0` to run `wc -l` on every log file.

## Common mistakes

- Using plain `xargs` with filenames that contain spaces.
- Removing files during the first attempt instead of previewing with `echo`.
- Forgetting `{}` when using `xargs -I {}`.

## GNU/Linux vs macOS notes

`find -print0` and `xargs -0` are available on GNU/Linux and macOS.

## Bash vs zsh notes

The pipeline works the same in Bash and zsh. Quote paths with spaces before they reach `find`.

## Check yourself

From the repository root:

```sh
./checks/check-11-xargs-batch-operations.sh
```

## Next lesson

Next you will create, list, extract, and compress archives.
