# Lesson 00: Setup

## Goal

Prepare your local Pipeworks workspace and understand the repository layout, sandbox, reset script, doctor script, and basic safety rules.

## Why this matters

Terminal practice should happen in a safe place. The sandbox lets you run real commands without risking your normal files.

## Before you start

Run commands from the repository root unless instructed otherwise:

```sh
pwd
```

You should see a path ending in `pipeworks`.

## Mental model

`fixtures/` is the clean copy. `sandbox/` is your practice copy. If the sandbox gets messy, reset it from fixtures.

## Commands introduced

- `pwd`
- `printf`
- `command -v`
- `bash --version`
- `zsh --version`

## Exercise 1: Smallest useful version

Run the doctor:

```sh
./tools/doctor.sh
```

Read the warnings. Optional tools can be missing.

## Exercise 2: Add one option

Reset the sandbox without an interactive prompt:

```sh
./tools/reset-sandbox.sh --yes
```

## Exercise 3: Combine with previous knowledge

List the first few lesson files:

```sh
printf 'Lessons:\n'
find lessons -maxdepth 1 -name '*.md' | sort | head
```

## Exercise 4: Realistic task

Create your first output file:

```sh
printf 'pipeworks ready\n' > sandbox/out/first-output.txt
```

Inspect it:

```sh
cat sandbox/out/first-output.txt
```

## Challenge

Find the matching solution file for this lesson without opening the README.

## Common mistakes

- Running `reset-sandbox.sh` from inside `sandbox/`; use `../tools/reset-sandbox.sh` if you are there.
- Treating optional doctor warnings as fatal.
- Forgetting that `>` overwrites a file.

## GNU/Linux vs macOS notes

This lesson uses portable commands.

## Bash vs zsh notes

The interactive commands work in Bash and zsh. The helper scripts run with Bash because of their shebang.

## Check yourself

From the repository root:

```sh
./checks/check-00-setup.sh
```

## Next lesson

Next you will learn how to orient yourself in a terminal session.
