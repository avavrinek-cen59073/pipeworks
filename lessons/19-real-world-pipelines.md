# Lesson 19: Real-world pipelines

## Goal

Build useful reports by combining searching, extraction, sorting, counting, config auditing, duplicate detection, and cleanup previews.

## Why this matters

Real command-line work is rarely one command. You build a pipeline in stages, inspect each stage, and save the final answer.

## Before you start

Run:

```sh
cd sandbox
```

Write final outputs to `out/`.

## Mental model

Build pipelines incrementally:

1. Start with the smallest command that returns relevant lines.
2. Add one transformation.
3. Inspect the output.
4. Add counting or sorting.
5. Save the final output.

Do not write a long pipeline from memory and hope it is correct.

## Tools reused

This lesson combines:

```sh
grep
sed
cut
sort
uniq
find
awk
du
```

## Exercise 1: Create a failure report

First inspect the raw matches:

```sh
grep -h 'status=failed' logs/*.log | head
```

Then build the report:

```sh
grep -h 'status=failed' logs/*.log \
  | sed -E 's/.*user=([^ ]+).*code=([^ ]+).*/user=\1 code=\2/' \
  | sort \
  | uniq -c \
  | sort -nr > out/failure-report.txt
cat out/failure-report.txt
```

Important pieces:

- `sed -E` enables grouped regular expressions.
- `([^ ]+)` captures one or more non-space characters.
- `\1` and `\2` reuse the captured user and code.
- `sort | uniq -c | sort -nr` creates a frequency table.

## Exercise 2: Audit deprecated config values

Run:

```sh
grep -R -n 'old-db.internal' configs > out/config-audit.txt
cat out/config-audit.txt
```

What it gives you:

- filename;
- line number;
- full matching line.

That is enough context to plan a safe migration.

## Exercise 3: Detect duplicate CSV users

Run:

```sh
cut -d, -f1 csv/duplicate-users.csv \
  | tail -n +2 \
  | sort \
  | uniq -d > out/duplicate-users-report.txt
cat out/duplicate-users-report.txt
```

This reuses a pattern from Lesson 08. The value of repetition is that you start recognizing report shapes.

## Exercise 4: Generate a cleanup plan

Run:

```sh
find messy -type f \( -name '*.tmp' -o -name '*.bak' -o -name '*~' \) -print \
  | sort > out/cleanup-plan.txt
cat out/cleanup-plan.txt
```

This is deliberately a plan, not a deletion command.

## Challenge

Create `out/incident-report.md` with sections for:

- top failed users;
- top IPs;
- unique error codes;
- first and last timestamp;
- services with most errors.

Build each section separately before grouping them into one Markdown file.

## When it goes wrong

- If a `sed` extraction returns the whole line unchanged, the pattern did not match. Test it on one sample line.
- If counts look too high, check whether the same event appears in multiple log files.
- If your cleanup plan contains unexpected paths, fix the `find` expression before turning it into any action.

## Check yourself

From the repository root:

```sh
./checks/check-19-real-world-pipelines.sh
```

## Next lesson

Next you will learn advanced shell patterns for robust scripts.
