# Solutions 07: Pipes, redirection, and streams

## Exercise 1

Task: Save error lines.

```sh
grep -h 'level=ERROR' logs/*.log > out/error-lines.txt
```

Why this works: stdout goes to the file.

## Exercise 2

Task: Append a summary.

```sh
printf 'error lines: ' > out/pipeline-summary.txt
wc -l < out/error-lines.txt >> out/pipeline-summary.txt
```

Why this works: `<` feeds a file to `wc`; `>>` appends.

## Exercise 3

Task: Separate stdout and stderr.

```sh
find missing-directory -type f > out/find-output.txt 2> out/find-errors.txt
```

Why this works: `>` redirects stdout and `2>` redirects stderr.

## Exercise 4

Task: View and save failed lines.

```sh
grep -h 'status=failed' logs/*.log | tee out/failed-lines.txt | wc -l
```

Why this works: `tee` writes a copy while the pipeline continues.

## Challenge

```sh
{
  printf 'WARN '
  grep -h 'level=WARN' logs/*.log | wc -l
  printf 'ERROR '
  grep -h 'level=ERROR' logs/*.log | wc -l
} > out/warn-and-error-counts.txt
```
