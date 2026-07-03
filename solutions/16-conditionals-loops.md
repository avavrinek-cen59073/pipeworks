# Solutions 16: Conditionals and loops

## Exercise 1

Task: Loop over logs.

```sh
for file in logs/*.log; do
  printf '%s: ' "$file"
  grep -c 'level=ERROR' "$file"
done > out/errors-per-log.txt
```

Why this works: the glob selects top-level logs and each filename is quoted.

## Exercise 2

Task: Skip blank and comment lines.

```sh
while IFS= read -r line; do
  case "$line" in
    ''|\#*) continue ;;
    *) printf '%s\n' "$line" ;;
  esac
done < configs/app.conf > out/app-active-lines.txt
```

## Exercise 3

Task: Handle files with spaces.

```sh
find messy -type f -print0 | while IFS= read -r -d '' file; do
  printf '%s\n' "$file"
done > out/all-messy-files.txt
```

Why this works: null delimiters preserve spaces and unusual characters.

## Exercise 4

Task: Generate a multi-section report.

```sh
{
  printf 'Errors per log\n'
  cat out/errors-per-log.txt
  printf '\nActive app config\n'
  cat out/app-active-lines.txt
} > out/multi-section-report.txt
```

## Challenge

Add:

```sh
printf '\nCleanup preview\n'
find messy -type f \( -name '*.tmp' -o -name '*.bak' -o -name '*~' \) -print | sort
```
