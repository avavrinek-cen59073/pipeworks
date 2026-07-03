# Lesson 00: Setup

## Goal

Get the course ready, understand what is safe to modify, and create your first checked output file.

## Why this matters

The terminal is powerful because commands act on real files. Pipeworks gives you a disposable practice area so you can learn real commands without practicing on your personal files.

## Before you start

Open a terminal in the repository root. If you are not sure where you are, run:

```sh
pwd
```

The printed path should end with `pipeworks`.

## Mental model

There are two important directories:

- `fixtures/` is the clean source copy. Do not practice there.
- `sandbox/` is your working copy. Lessons are designed for this directory.

When you run `./tools/reset-sandbox.sh`, Pipeworks rebuilds `sandbox/` from `fixtures/`. That means mistakes inside `sandbox/` are recoverable.

## Commands introduced

```sh
pwd
printf
command -v
bash --version
zsh --version
```

Command anatomy:

- `pwd` prints the current directory. It takes no required arguments.
- `printf 'text\n'` prints exactly the text you give it. `\n` means newline.
- `command -v NAME` asks the shell where a command named `NAME` comes from.
- `bash --version` and `zsh --version` ask those shells to print version information. The `--version` part is an option.

## Exercise 1: Check your tools

Run:

```sh
./tools/doctor.sh
```

What to notice:

- `./tools/doctor.sh` means "run the file named `doctor.sh` inside the `tools` directory under the current directory".
- The leading `./` matters because most shells do not automatically run programs from the current directory.
- Warnings for optional tools are not a failure. The main course avoids optional dependencies.

## Exercise 2: Reset the sandbox

Run:

```sh
./tools/reset-sandbox.sh --yes
```

What each part does:

- `./tools/reset-sandbox.sh` runs the reset script.
- `--yes` answers the script's safety prompt non-interactively.
- The script recreates `sandbox/` from `fixtures/` and makes sure `sandbox/out/` exists.

## Exercise 3: Find course files

Run:

```sh
find lessons -maxdepth 1 -name '*.md' | sort | head
```

Read it left to right:

- `find lessons` searches inside the `lessons` directory.
- `-maxdepth 1` means "do not go into subdirectories".
- `-name '*.md'` matches Markdown files. The quotes stop your shell from expanding `*.md` too early.
- `| sort` sends the list into `sort`.
- `| head` shows only the first few lines.

## Exercise 4: Create your first output file

Run:

```sh
printf 'pipeworks ready\n' > sandbox/out/first-output.txt
cat sandbox/out/first-output.txt
```

What each part does:

- `printf 'pipeworks ready\n'` creates one line of text.
- `>` writes that text to a file. If the file already exists, it replaces the file.
- `cat FILE` prints the file so you can inspect what you wrote.

## Challenge

Find the solution file for this lesson using a command, not by browsing manually.

Hint: solution filenames match lesson filenames.

## When it goes wrong

- If `./tools/doctor.sh` says "No such file", you are probably not in the repository root. Run `pwd`.
- If `sandbox/out/first-output.txt` cannot be created, reset the sandbox and confirm `sandbox/out/` exists.
- If you accidentally overwrite `first-output.txt`, write it again. This is why exercises use `sandbox/out/`.

## Check yourself

From the repository root:

```sh
./checks/check-00-setup.sh
```

## Next lesson

Next you will learn how to orient yourself in a terminal session.
