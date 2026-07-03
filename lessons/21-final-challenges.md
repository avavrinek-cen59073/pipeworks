# Lesson 21: Final challenges

## Goal

Apply the course by producing clear reports and one automation script from the sandbox data.

## Why this matters

Real work does not usually tell you which exact command to run. You define the question, inspect the data, build a pipeline, and save an answer someone else can read.

## Before you start

Run:

```sh
cd sandbox
mkdir -p out/final
```

## Mental model

For each challenge:

1. Write the question in plain language.
2. Find the relevant files.
3. Build and inspect one command at a time.
4. Save output under `out/final/`.
5. Include enough context that another person can understand the report.

You are not being graded on cleverness. Prefer readable commands and clear output.

## Commands reused

Use the tools from previous lessons:

```sh
find grep sed awk sort uniq cut tr wc du tar xargs
```

## Exercise 1: Log investigation

Create:

```text
out/final/log-investigation.md
```

Include:

- top failed users;
- top IPs;
- unique error codes;
- first and last timestamp;
- services with most errors.

Start with separate exploratory commands. Example shape:

```sh
grep -h 'status=failed' logs/*.log | grep -o 'user=[^ ]*'
```

Then add `cut`, `sort`, `uniq -c`, and `sort -nr` after the extraction looks right.

## Exercise 2: Config migration

Create:

```text
out/final/config-migration.md
out/final/migrated-configs/
```

Include:

- files containing deprecated hostnames;
- copied configs that need migration;
- replacements applied to the copies only;
- a short summary of what changed.

Important: do not edit files under `configs/` directly. Work on copies.

## Exercise 3: Disk cleanup audit

Create:

```text
out/final/cleanup-audit.md
```

Include:

- largest paths;
- temp files;
- backup files;
- a deletion plan that does not delete originals.

The output should read like a plan you could review before taking action.

## Exercise 4: CSV business report

Create:

```text
out/final/csv-business-report.md
```

Include:

- expenses by department;
- duplicate users;
- missing fields;
- sorted sales totals.

Build each section separately, then combine them with command grouping.

## Challenge: Scripted automation

Write:

```text
out/final/project-audit.sh
```

The script should create a Markdown audit report from sandbox data. It should:

- use a Bash shebang;
- validate that required directories exist;
- create `out/final/` if needed;
- write a single report file;
- keep cleanup actions as previews only.

## When it goes wrong

- If a report is hard to read, add headings and blank lines. Output quality matters.
- If one giant pipeline is hard to debug, split it into smaller commands first.
- If your script only works from one directory, either document that or validate the current directory at startup.

## Check yourself

Read each final output as if another person will use it. It should say what you checked, what you found, and where any migrated or generated files are.

## Next lesson

There is no next lesson. Reset the sandbox and repeat selected lessons until the workflows feel natural.
