# Lesson 20: Advanced shell patterns

## Goal

Use robust quoting, Bash arrays, traps, temporary directories, cleanup on exit, strict mode tradeoffs, command grouping, subshells, and process substitution.

## Why this matters

Advanced shell work is less about clever one-liners and more about writing scripts that fail safely and clean up after themselves.

## Before you start

```sh
cd sandbox
```

Use `out/advanced-report.sh` for this lesson.

## Mental model

Scripts have resources: arguments, files, temporary directories, and child commands. Robust scripts validate inputs and clean resources even when something fails.

## Commands introduced

- robust quoting
- Bash arrays
- `trap`
- temporary directories
- cleanup on exit
- strict mode tradeoffs
- command grouping
- subshells
- process substitution

## Exercise 1: Smallest useful version

Create a temporary workspace:

```sh
tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/pipeworks.XXXXXX")
printf '%s\n' "$tmp_dir" > out/temp-workspace.txt
rm -rf "$tmp_dir"
```

## Exercise 2: Add one option

Create `out/advanced-report.sh` with cleanup:

```sh
#!/usr/bin/env bash
set -euo pipefail

tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/pipeworks.XXXXXX")
cleanup() {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

printf 'temporary workspace: %s\n' "$tmp_dir" >&2
grep -h 'level=ERROR' logs/*.log > "$tmp_dir/errors.log"
wc -l "$tmp_dir/errors.log"
```

## Exercise 3: Combine with previous knowledge

Add a Bash array of report sections:

```sh
sections=(errors warnings failures)
printf '%s\n' "${sections[@]}"
```

Clearly mark this as Bash-specific.

## Exercise 4: Realistic task

Use command grouping to create one report:

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

Compare Bash arrays with a portable newline-delimited list. Explain which one you would use for paths with spaces.

## Common mistakes

- Forgetting to quote `"$tmp_dir"`.
- Using arrays in a script declared with `#!/bin/sh`.
- Assuming process substitution works in every shell.

## GNU/Linux vs macOS notes

`mktemp -d "${TMPDIR:-/tmp}/name.XXXXXX"` works on GNU/Linux and macOS.

## Bash vs zsh notes

Bash arrays and zsh arrays differ. This lesson's script examples are Bash-specific.

## Check yourself

Run:

```sh
bash -n out/advanced-report.sh
bash out/advanced-report.sh
```

## Next lesson

Next you will complete capstone challenges with minimal hints.
