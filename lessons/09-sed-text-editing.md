# Lesson 09: sed: text editing

## Goal

Use `sed` to substitute text, delete lines, print selected lines, and safely prepare edited copies.

## Why this matters

You often need to clean config files or transform text before passing it to another command.

## Before you start

```sh
cd sandbox
```

Required files are in `configs/`.

## Mental model

`sed` reads input line by line and writes transformed output. Prefer writing to a new file before editing in place.

## Commands introduced

- `sed 's/old/new/'`
- `sed 's/old/new/g'`
- `sed -E`
- `sed -n`
- `sed '/pattern/d'`
- `sed '/^#/d'`

## Exercise 1: Smallest useful version

Replace a hostname in output only:

```sh
sed 's/old-db.internal/db.internal.local/g' configs/database.conf > out/database-migrated.conf
cat out/database-migrated.conf
```

## Exercise 2: Add one option

Remove comments and blank lines:

```sh
sed '/^[[:space:]]*#/d; /^[[:space:]]*$/d' configs/app.conf > out/app-no-comments.conf
cat out/app-no-comments.conf
```

## Exercise 3: Combine with previous knowledge

Show only lines that contain host-like keys:

```sh
sed -n '/host/p' configs/services.ini > out/service-hosts.txt
cat out/service-hosts.txt
```

## Exercise 4: Realistic task

Copy a config, then edit the copy in place.

```sh
cp configs/database.conf out/database-copy.conf
```

GNU/Linux:

```sh
sed -i 's/old-db.internal/db.internal.local/g' out/database-copy.conf
```

macOS:

```sh
sed -i '' 's/old-db.internal/db.internal.local/g' out/database-copy.conf
```

## Challenge

Normalize spaces around `=` in `configs/app.conf` and save the result to `out/app-normalized.conf`.

## Common mistakes

- Using `sed -i` on the original before testing output.
- Forgetting the empty string argument for macOS `sed -i ''`.
- Expecting `s/old/new/` to replace every occurrence without the `g` flag.

## GNU/Linux vs macOS notes

`sed -i` differs:

```sh
# GNU/Linux
sed -i 's/old/new/g' file

# macOS/BSD
sed -i '' 's/old/new/g' file
```

## Bash vs zsh notes

Quote sed scripts in both shells so the shell does not interpret special characters.

## Check yourself

From the repository root:

```sh
./checks/check-09-sed-text-editing.sh
```

## Next lesson

Next you will process structured text with `awk`.
