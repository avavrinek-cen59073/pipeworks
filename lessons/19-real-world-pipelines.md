# Lesson 19: Real-world pipelines

## Goal

Build integrated reports from logs, configs, disk usage, CSV duplicates, cleanup previews, and incident data.

## Why this matters

Most terminal work combines several small tools into repeatable investigations.

## Before you start

```sh
cd sandbox
```

Write all outputs to `out/`.

## Mental model

Start with a narrow question, build a pipeline one stage at a time, inspect each stage, then save the final result.

## Commands introduced

This lesson combines previous commands: `grep`, `find`, `sort`, `uniq`, `cut`, `awk`, `du`, `sed`, and redirection.

## Exercise 1: Smallest useful version

Create a log failure report:

```sh
grep -h 'status=failed' logs/*.log \
  | sed -E 's/.*user=([^ ]+).*code=([^ ]+).*/user=\1 code=\2/' \
  | sort \
  | uniq -c \
  | sort -nr > out/failure-report.txt
cat out/failure-report.txt
```

## Exercise 2: Add one option

Create a config audit:

```sh
grep -R -n 'old-db.internal' configs > out/config-audit.txt
cat out/config-audit.txt
```

## Exercise 3: Combine with previous knowledge

Detect duplicate CSV users:

```sh
cut -d, -f1 csv/duplicate-users.csv \
  | tail -n +2 \
  | sort \
  | uniq -d > out/duplicate-users-report.txt
cat out/duplicate-users-report.txt
```

## Exercise 4: Realistic task

Generate a disk cleanup preview:

```sh
find messy -type f \( -name '*.tmp' -o -name '*.bak' -o -name '*~' \) -print \
  | sort > out/cleanup-plan.txt
cat out/cleanup-plan.txt
```

## Challenge

Create `out/incident-report.md` with sections for top failed users, top IPs, unique error codes, first and last timestamp, and services with most errors.

## Common mistakes

- Building a long pipeline without checking intermediate output.
- Saving reports outside `out/`.
- Letting cleanup previews become cleanup actions too early.

## GNU/Linux vs macOS notes

The commands here avoid GNU-only flags.

## Bash vs zsh notes

Backslash line continuations work in Bash and zsh. Do not add trailing spaces after `\`.

## Check yourself

From the repository root:

```sh
./checks/check-19-real-world-pipelines.sh
```

## Next lesson

Next you will learn advanced shell patterns for robust scripts.
