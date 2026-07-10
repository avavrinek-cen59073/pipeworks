# Lesson 02: Files, directories, and globs

## Goal

Create, copy, rename, and remove files safely while learning how globs and quoted paths behave.

## Why this matters

File commands are simple until you run them against the wrong target. This lesson builds the habit of previewing paths before changing them.

## Before you start

Run:

```sh
cd sandbox
```

You will use files under `messy/` and write practice files under `out/file-practice/`.

## Mental model

The shell expands globs before the command runs.

```sh
cp messy/*.txt out/file-practice/
```

Before `cp` starts, the shell turns `messy/*.txt` into a list of matching paths such as:

```text
messy/duplicate.txt messy/empty-file.txt messy/mixed_case.txt
```

Quotes matter because spaces split arguments:

```sh
"messy/spaces in names/quarterly draft.txt"
```

The quotes make that whole path one argument.

## Commands introduced

```sh
mkdir
touch
cp
mv
rm
printf
```

Command anatomy:

- `mkdir -p DIR`: create a directory. `-p` also creates missing parents and does not complain if the directory already exists.
- `touch FILE`: create an empty file if it does not exist, or update its timestamp if it does.
- `cp SOURCE DEST`: copy a file. If `DEST` is a directory, the copy keeps the original filename.
- `mv SOURCE DEST`: move or rename a file.
- `rm FILE`: remove a file. It does not move the file to a trash folder.
- `printf '%s\n' VALUES...`: print each value on its own line.

## Exercise 1: Create a safe practice area

Run:

```sh
mkdir -p out/file-practice
touch out/file-practice/empty-note.txt
ls out/file-practice
```

What this teaches:

- You are not practicing in `messy/`; you are creating copies under `out/`.
- `mkdir -p` makes this exercise repeatable.

## Exercise 2: Copy files selected by a glob

Run:

```sh
printf '%s\n' messy/*.txt
cp messy/*.txt out/file-practice/
ls out/file-practice
```

The first command is a preview. It shows what `messy/*.txt` expands to before you pass the same pattern to `cp`.

## Exercise 3: Copy a path with spaces

Run:

```sh
cp "messy/spaces in names/quarterly draft.txt" out/file-practice/
ls out/file-practice
```

Without quotes, the shell would split the source into several arguments: `messy/spaces`, `in`, `names/quarterly`, and `draft.txt`.

## Exercise 4: Remove only a known practice file

Run:

```sh
printf 'About to remove: %s\n' out/file-practice/empty-note.txt
rm out/file-practice/empty-note.txt
ls out/file-practice
```

This is not saying "always list before every `rm`". It is teaching the safer habit: when a command deletes something, make the target explicit and inspect it when you are learning or using a pattern.

## Challenge

Rename the copied `quarterly draft.txt` to `quarterly-draft.txt` inside `out/file-practice/`.

## When it goes wrong

- If a path with spaces fails, check whether you quoted the whole path.
- If `cp messy/*.txt ...` says no matches in zsh, the glob did not match from your current directory. Run `pwd`.
- If you remove a file in `out/file-practice/`, recreate it from `messy/`. If you damage `sandbox/`, reset it.

## Check yourself

Use:

```sh
ls out/file-practice
```

You should see copied files, and `empty-note.txt` should be gone after Exercise 4.

## Next lesson

Next you will inspect file contents without editing them.
