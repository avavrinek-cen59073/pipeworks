# Lesson 20: Advanced shell patterns

## Goal

Use temporary directories, traps, arrays, command grouping, subshells, and strict-mode tradeoffs to write safer Bash scripts.

## Why this matters

Advanced shell scripting is not about making commands shorter. It is about making failure safer and making scripts understandable after you come back later.

## Before you start

Run:

```sh
cd sandbox
```

You will create `out/advanced-report.sh`.

## Mental model

Robust scripts manage resources:

- inputs;
- outputs;
- temporary files;
- cleanup;
- error handling.

If a script creates a temporary directory, it should remove that directory whether the script succeeds or fails.

## Syntax introduced

```sh
mktemp -d
trap cleanup EXIT
array=(one two three)
"${array[@]}"
{ command1; command2; } > file
( cd dir && command )
```

What these pieces mean:

- `mktemp -d`: create a unique temporary directory.
- `trap cleanup EXIT`: run `cleanup` when the script exits.
- `array=(...)`: Bash array.
- `"${array[@]}"`: expand array elements safely as separate arguments.
- `{ ...; } > file`: group commands and redirect their combined output.
- `( ... )`: run commands in a subshell so directory changes do not affect the parent shell.

## Exercise 1: Create and remove a temporary workspace

Run:

```sh
tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/pipeworks.XXXXXX")
printf '%s\n' "$tmp_dir" > out/temp-workspace.txt
rm -rf "$tmp_dir"
```

What it means:

- `$(...)` captures command output.
- `${TMPDIR:-/tmp}` uses `$TMPDIR` if set, otherwise `/tmp`.
- The `XXXXXX` part is replaced by `mktemp` to make a unique path.

## Exercise 2: Add cleanup with a trap

Create `out/advanced-report.sh`:

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

Why this is safer: `cleanup` runs even if a later command fails.

## Exercise 3: Use a Bash array

Add this to the script or run it interactively in Bash:

```sh
sections=(errors warnings failures)
printf '%s\n' "${sections[@]}"
```

Arrays are useful when you need a list where each item must remain separate.

## Exercise 4: Group commands into one report

Run:

```sh
{
  printf '# Advanced report\n\n'
  printf '## Error count\n'
  grep -h 'level=ERROR' logs/*.log | wc -l
  printf '\n## Deprecated configs\n'
  grep -R -l 'old-db.internal' configs
} > out/advanced-report.md
cat out/advanced-report.md
```

The braces let one redirection apply to the whole block.

## Challenge

Compare a Bash array with a newline-delimited list for storing filenames. Which one is safer for filenames with spaces? When would `find -print0` be safer than both?

## When it goes wrong

- If cleanup removes the wrong path, print the temp path to stderr before deleting and quote `"$tmp_dir"`.
- If an array script is run with `sh`, it will fail. Use a Bash shebang.
- If strict mode exits earlier than expected, inspect which command returned non-zero and decide whether that failure is acceptable.

## Compatibility notes

Bash arrays are Bash-specific. zsh has arrays too, but indexing and behavior differ. The scripts in this lesson should use `#!/usr/bin/env bash`.

## Check yourself

Run:

```sh
bash -n out/advanced-report.sh
bash out/advanced-report.sh
```

## Next lesson

Next you will complete capstone challenges with minimal hints.
