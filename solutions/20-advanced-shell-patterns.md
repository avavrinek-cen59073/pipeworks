# Solutions 20: Advanced shell patterns

## Exercise 1

Task: Create and remove a temporary workspace.

```sh
tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/pipeworks.XXXXXX")
printf '%s\n' "$tmp_dir" > out/temp-workspace.txt
rm -rf "$tmp_dir"
```

Why this works: `mktemp -d` creates a unique directory and quoting protects the path.

## Exercise 2

Task: Add trap cleanup.

Use the script from the lesson:

```sh
tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/pipeworks.XXXXXX")
cleanup() {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT
```

Why this works: the cleanup function runs when the script exits.

## Exercise 3

Task: Add a Bash array.

```sh
sections=(errors warnings failures)
printf '%s\n' "${sections[@]}"
```

Why this works: `"${sections[@]}"` preserves each element as a separate word.

## Exercise 4

Task: Use command grouping for one report.

```sh
{
  printf '# Advanced report\n\n'
  printf '## Error count\n'
  grep -h 'level=ERROR' logs/*.log | wc -l
  printf '\n## Deprecated configs\n'
  grep -R -l 'old-db.internal' configs
} > out/advanced-report.md
```

## Challenge

For paths with spaces, Bash arrays are safer inside Bash scripts. For portable pipelines, use newline-delimited or null-delimited streams; prefer null-delimited streams when filenames are involved.
