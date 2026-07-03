# Solutions 15: Script arguments and options

## Exercise 1

Task: Start from `parse-log.sh`.

```sh
cp scripts/parse-log.sh out/log-tool.sh
chmod +x out/log-tool.sh
out/log-tool.sh logs/auth.log
```

Why this works: copying keeps the original fixture unchanged.

## Exercise 2

Task: Add `--help`.

Use a `usage()` function:

```sh
usage() {
  printf 'Usage: %s [--help] [--count] [--errors-only] LOGFILE\n' "${0##*/}"
}
```

Then handle it in a `case` statement.

## Exercise 3

Task: Add `--count`.

Set a flag while parsing:

```sh
count_only=0
case "$1" in
  --count) count_only=1; shift ;;
esac
```

Then use `grep -c` when the flag is set.

## Exercise 4

Task: Reject unknown options.

```sh
case "$1" in
  --help) usage; exit 0 ;;
  --count) count_only=1; shift ;;
  --errors-only) errors_only=1; shift ;;
  --*) printf 'Unknown option: %s\n' "$1" >&2; usage >&2; exit 2 ;;
esac
```

Common mistake: accepting `--bad-option` as a filename.

## Challenge

Use a `while [ "$#" -gt 0 ]` parser and keep one `log_file` variable. Reject a second non-option argument.
