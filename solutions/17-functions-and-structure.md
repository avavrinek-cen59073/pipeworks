# Solutions 17: Functions and structure

## Exercise 1

Task: Create `out/function-report.sh`.

Use the script from the lesson. It defines `usage`, `die`, `log_info`, and `main`.

Why this works: each function has one job, and `main "$@"` keeps argument handling explicit.

## Exercise 2

Task: Make it executable and run it.

```sh
chmod +x out/function-report.sh
out/function-report.sh logs/app-2026-06-02.log
```

## Exercise 3

Task: Redirect stdout and stderr separately.

```sh
out/function-report.sh logs/app-2026-06-02.log > out/function-count.txt 2> out/function-debug.txt
```

Why this works: the count goes to stdout and the info message goes to stderr.

## Exercise 4

Task: Add `print_error_lines`.

```sh
print_error_lines() {
  local log_file=$1
  grep 'level=ERROR' "$log_file"
}
```

Call it from `main` after printing the count.

## Challenge

```sh
validate_log_file() {
  local log_file=$1
  [ -f "$log_file" ] || die "missing file: $log_file"
}
```

Then replace the inline validation with `validate_log_file "$log_file"`.
