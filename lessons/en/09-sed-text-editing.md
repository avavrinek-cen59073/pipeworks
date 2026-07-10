# Lesson 09: sed: text editing

## Goal

Use `sed` to substitute text, delete lines, print selected lines, and safely edit copied files.

## Why this matters

`sed` is useful when you need to transform text in a pipeline or prepare a changed copy of a config file.

## Before you start

Run:

```sh
cd sandbox
```

You will use `configs/`.

## Mental model

`sed` reads input line by line and applies editing commands. By default, it prints each processed line.

Most `sed` work in this course follows one of these forms:

```sh
sed 's/old/new/' file
sed '/pattern/d' file
sed -n '/pattern/p' file
```

Prefer writing to a new file until you are confident.

## Commands introduced

```sh
sed 's/old/new/'
sed 's/old/new/g'
sed -E 's/pattern/replacement/'
sed -n '/pattern/p'
sed '/pattern/d'
sed '/^#/d'
```

Command meanings:

- `s/old/new/`: replace the first `old` on each line.
- `s/old/new/g`: replace all occurrences on each line. `g` means global within the line.
- `-E`: use extended regular expressions.
- `-n`: do not print every line automatically.
- `/pattern/p`: print lines matching `pattern`.
- `/pattern/d`: delete lines matching `pattern`.
- `^#`: match `#` at the start of a line.

## Exercise 1: Replace text in output only

Run:

```sh
sed 's/old-db.internal/db.internal.local/g' configs/database.conf > out/database-migrated.conf
cat out/database-migrated.conf
```

This does not edit `configs/database.conf`. It writes a changed copy to `out/database-migrated.conf`.

## Exercise 2: Remove comments and blank lines

Run:

```sh
sed '/^[[:space:]]*#/d; /^[[:space:]]*$/d' configs/app.conf > out/app-no-comments.conf
cat out/app-no-comments.conf
```

Pattern meanings:

- `^[[:space:]]*#` matches a comment line, including comments with leading spaces.
- `^[[:space:]]*$` matches a blank or whitespace-only line.
- `;` separates two `sed` commands.

## Exercise 3: Print selected lines

Run:

```sh
sed -n '/host/p' configs/services.ini > out/service-hosts.txt
cat out/service-hosts.txt
```

Why `-n` matters: without it, `sed` would print every line and also print matching lines again.

## Exercise 4: Edit a copied file in place

First copy the file:

```sh
cp configs/database.conf out/database-copy.conf
```

Then use the command for your system.

GNU/Linux:

```sh
sed -i 's/old-db.internal/db.internal.local/g' out/database-copy.conf
```

macOS:

```sh
sed -i '' 's/old-db.internal/db.internal.local/g' out/database-copy.conf
```

Inspect the result:

```sh
cat out/database-copy.conf
```

## Challenge

Normalize spaces around `=` in `configs/app.conf` and save the result to `out/app-normalized.conf`.

## When it goes wrong

- If only the first occurrence on a line changed, you probably forgot the final `g`.
- If macOS says `sed: 1: ... invalid command code`, check the `sed -i ''` syntax.
- If you damaged a config, reset the sandbox. In real work, make a copy or backup before in-place editing.

## Compatibility notes

`sed -i` differs between GNU/Linux and macOS. For portable lessons, prefer redirecting to a new file:

```sh
sed 's/old/new/g' input > output
```

## Check yourself

From the repository root:

```sh
./checks/check-09-sed-text-editing.sh
```

## Next lesson

Next you will process structured text with `awk`.
