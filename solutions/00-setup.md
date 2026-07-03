# Solutions 00: Setup

## Exercise 1

Task: Run the doctor.

One solution:

```sh
./tools/doctor.sh
```

Why this works: the script checks common commands and prints warnings instead of failing aggressively. Optional tools can be missing.

Common mistake: treating an optional `zip`, `shellcheck`, or `lsof` warning as a blocker.

## Exercise 2

Task: Reset the sandbox without a prompt.

```sh
./tools/reset-sandbox.sh --yes
```

Why this works: `--yes` confirms the rebuild. The sandbox is copied from `fixtures/`.

## Exercise 3

Task: Find lesson files.

```sh
find lessons -maxdepth 1 -name '*.md' | sort | head
```

Why this works: `find` lists Markdown files, `sort` orders them, and `head` keeps the output short.

## Exercise 4

Task: Create your first output file.

```sh
printf 'pipeworks ready\n' > sandbox/out/first-output.txt
```

Why this works: `printf` writes predictable text and `>` saves it.

Alternative: use a text editor, but keep the file under `sandbox/out/`.

## Challenge

```sh
find solutions -maxdepth 1 -name '00-*.md'
```
