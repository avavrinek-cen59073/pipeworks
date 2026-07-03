# Lesson 01: Terminal orientation

## Goal

Understand prompts, current directory, paths, command structure, flags, and arguments.

## Why this matters

Most terminal mistakes start with running the right command in the wrong directory or misunderstanding which text is the command and which text is data.

## Before you start

```sh
cd sandbox
pwd
```

## Mental model

Your shell has a current directory. Relative paths start there. Absolute paths start at the filesystem root `/`. Commands have a name, optional flags, and optional arguments.

## Commands introduced

- `pwd`
- `ls`
- `cd`
- `echo`
- `printf`

## Exercise 1: Smallest useful version

Show your current directory:

```sh
pwd
```

## Exercise 2: Add one option

List visible files in the sandbox:

```sh
ls
```

Then list one directory:

```sh
ls logs
```

## Exercise 3: Combine with previous knowledge

Move to `logs`, print the directory, then move back:

```sh
cd logs
pwd
cd ..
pwd
```

## Exercise 4: Realistic task

Save your current directory and a short note:

```sh
pwd > out/current-directory.txt
printf 'I am practicing command structure.\n' >> out/current-directory.txt
```

Inspect the file:

```sh
cat out/current-directory.txt
```

## Challenge

Use one command to print the names of `logs`, `csv`, and `configs` on separate lines.

## Common mistakes

- Typing the prompt symbol as part of the command.
- Assuming `cd sandbox` works when you are already inside `sandbox`.
- Using `echo` for precise output when `printf` is clearer.

## GNU/Linux vs macOS notes

The commands in this lesson behave the same for this use.

## Bash vs zsh notes

Basic navigation is the same in Bash and zsh.

## Check yourself

Confirm that `out/current-directory.txt` contains a path ending in `sandbox`.

## Next lesson

Next you will create, copy, move, and remove files safely.
