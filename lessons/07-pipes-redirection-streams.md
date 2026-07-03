# Lesson 07: Pipes, redirection, and streams

## Goal

Use stdin, stdout, stderr, exit status, pipes, redirection, append, and `tee`.

## Why this matters

Shell fluency comes from connecting small commands and saving the right output in the right place.

## Before you start

```sh
cd sandbox
```

## Mental model

Most commands read input, write normal output to stdout, write errors to stderr, and return an exit status. Pipes connect stdout to another command's stdin.

## Commands introduced

- `|`
- `>`
- `>>`
- `2>`
- `2>&1`
- `tee`
- `echo $?`

## Exercise 1: Smallest useful version

Save error lines:

```sh
grep -h 'level=ERROR' logs/*.log > out/error-lines.txt
```

## Exercise 2: Add one option

Append a summary:

```sh
printf 'error lines: ' > out/pipeline-summary.txt
wc -l < out/error-lines.txt >> out/pipeline-summary.txt
```

## Exercise 3: Combine with previous knowledge

Separate normal output from errors:

```sh
find missing-directory -type f > out/find-output.txt 2> out/find-errors.txt
echo $?
```

The non-zero status is expected because the directory does not exist.

## Exercise 4: Realistic task

View and save a count at the same time:

```sh
grep -h 'status=failed' logs/*.log | tee out/failed-lines.txt | wc -l
```

## Challenge

Create `out/warn-and-error-counts.txt` with one count for `WARN` and one count for `ERROR`.

## Common mistakes

- Thinking `2>` redirects normal output. It redirects stderr.
- Using `>` when you meant `>>`.
- Forgetting that a pipeline only passes stdout by default.

## GNU/Linux vs macOS notes

The redirection syntax is shell syntax and works in Bash and zsh on GNU/Linux and macOS.

## Bash vs zsh notes

`echo $?` works in both Bash and zsh. The value is the previous command's exit status.

## Check yourself

From the repository root:

```sh
./checks/check-07-pipes-redirection-streams.sh
```

## Next lesson

Next you will build simple summaries with `sort`, `uniq`, `wc`, `cut`, and `tr`.
