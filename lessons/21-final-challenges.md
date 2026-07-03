# Lesson 21: Final challenges

## Goal

Apply the course by completing capstone investigations with minimal hints.

## Why this matters

Real terminal work rarely says which exact command to use. You define the question, build the pipeline, inspect results, and write a clear output.

## Before you start

```sh
cd sandbox
```

Create a directory for final outputs:

```sh
mkdir -p out/final
```

## Mental model

Work iteratively. Save intermediate files if they help. Prefer readable pipelines over dense one-liners.

## Commands introduced

No new commands. Use the tools from previous lessons.

## Exercise 1: Smallest useful version

Log investigation. Create `out/final/log-investigation.md` with:

- top failed users;
- top IPs;
- unique error codes;
- first and last timestamp;
- services with most errors.

## Exercise 2: Add one option

Config migration. Create `out/final/config-migration.md` and `out/final/migrated-configs/`:

- find deprecated hostnames;
- copy affected configs;
- replace values safely in the copies;
- produce a summary report.

## Exercise 3: Combine with previous knowledge

Disk cleanup audit. Create `out/final/cleanup-audit.md` with:

- largest paths;
- temp files;
- backup files;
- deletion plan that does not delete originals.

## Exercise 4: Realistic task

CSV business report. Create `out/final/csv-business-report.md` with:

- expenses by department;
- duplicate users;
- missing fields;
- sorted sales totals.

## Challenge

Scripted automation. Write `out/final/project-audit.sh` that creates a complete project audit report from sandbox data.

## Common mistakes

- Skipping written output and leaving only terminal history.
- Deleting original files during cleanup planning.
- Ignoring filenames with spaces in final scripts.

## GNU/Linux vs macOS notes

Avoid GNU-only flags unless you include alternatives in your report.

## Bash vs zsh notes

If you write a script with Bash arrays, mark it Bash-specific and use `#!/usr/bin/env bash`.

## Check yourself

Read each final output as if another person will use it. It should explain what you checked, what command shape you used, and what you found.

## Next lesson

There is no next lesson. Reset the sandbox and repeat selected lessons until the workflows feel natural.
