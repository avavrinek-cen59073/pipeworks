# Lesson 01: Terminal orientation

## Goal

Understand where commands run, how paths work, and how command names, options, and arguments fit together.

## Why this matters

A correct command in the wrong directory can fail or change the wrong files. Before learning complicated commands, you need to know how to answer "where am I?" and "what am I passing to this command?"

## Before you start

Run:

```sh
cd sandbox
pwd
```

You should now be inside the sandbox directory.

## Mental model

Your shell always has a current directory.

- A relative path like `logs/auth.log` starts from the current directory.
- An absolute path like `/Users/name/git/pipeworks/sandbox/logs/auth.log` starts from `/`.
- `.` means the current directory.
- `..` means the parent directory.

A command line usually looks like this:

```text
command option argument
```

Example:

```sh
ls -l logs
```

- `ls` is the command.
- `-l` is an option that changes the output format.
- `logs` is the argument: the path to list.

## Commands introduced

```sh
pwd
ls
cd
echo
printf
```

What they do:

- `pwd`: print working directory.
- `ls PATH`: list a directory. Without `PATH`, it lists the current directory.
- `cd PATH`: change the shell's current directory.
- `echo TEXT`: print text with a newline. Useful, but less predictable than `printf`.
- `printf FORMAT VALUES`: print formatted text. Use it when exact output matters.

## Exercise 1: Ask where you are

Run:

```sh
pwd
```

Do not just check that it prints something. Read the path. It should end in `sandbox`.

## Exercise 2: List current and child directories

Run:

```sh
ls
ls logs
```

What changed:

- `ls` listed your current directory: the sandbox.
- `ls logs` listed the `logs` directory inside the sandbox.

## Exercise 3: Move, verify, move back

Run:

```sh
cd logs
pwd
cd ..
pwd
```

What each path means:

- `cd logs` moves into the child directory named `logs`.
- `cd ..` moves up one directory.
- The two `pwd` commands prove where the shell is after each move.

## Exercise 4: Save orientation notes

Run:

```sh
pwd > out/current-directory.txt
printf 'I am practicing command structure.\n' >> out/current-directory.txt
cat out/current-directory.txt
```

What to notice:

- `>` writes a new file.
- `>>` appends to an existing file.
- `out/current-directory.txt` is a relative path from `sandbox`.

## Challenge

Print the names `logs`, `csv`, and `configs` on separate lines using one command.

Hint: `printf` can print several values with one format string.

## When it goes wrong

- If `cd logs` fails, run `pwd`. You may not be in `sandbox`.
- If `out/current-directory.txt` is missing, check whether you wrote to `sandbox/out/` or to a different `out/` directory.
- If you typed a prompt character like `$` or `%`, remove it. Prompts are not part of commands.

## Check yourself

Confirm that `out/current-directory.txt` contains a path ending in `sandbox` and your note.

## Next lesson

Next you will create, copy, move, and remove files safely.
