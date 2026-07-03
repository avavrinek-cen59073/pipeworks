# Solutions 09: sed: text editing

## Exercise 1

Task: Replace a hostname in output.

```sh
sed 's/old-db.internal/db.internal.local/g' configs/database.conf > out/database-migrated.conf
```

Why this works: `s/old/new/g` replaces every occurrence on each line.

## Exercise 2

Task: Remove comments and blank lines.

```sh
sed '/^[[:space:]]*#/d; /^[[:space:]]*$/d' configs/app.conf > out/app-no-comments.conf
```

Why this works: the first command deletes comments; the second deletes blank lines.

## Exercise 3

Task: Print host lines.

```sh
sed -n '/host/p' configs/services.ini > out/service-hosts.txt
```

Why this works: `-n` suppresses default printing and `p` prints matching lines.

## Exercise 4

Task: Edit a copied config safely.

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

```sh
sed -E 's/[[:space:]]*=[[:space:]]*/ = /g' configs/app.conf > out/app-normalized.conf
```
