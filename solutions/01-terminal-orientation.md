# Solutions 01: Terminal orientation

## Exercise 1

Task: Show the current directory.

```sh
pwd
```

Why this works: `pwd` prints the shell's current working directory.

## Exercise 2

Task: List sandbox files and one directory.

```sh
ls
ls logs
```

Why this works: `ls` with no argument lists the current directory; with an argument it lists that path.

## Exercise 3

Task: Move to `logs`, print the directory, then move back.

```sh
cd logs
pwd
cd ..
pwd
```

Common mistake: running `cd logs` again while already inside `logs`.

## Exercise 4

Task: Save your current directory and a note.

```sh
pwd > out/current-directory.txt
printf 'I am practicing command structure.\n' >> out/current-directory.txt
```

Why this works: `>` creates or replaces the file; `>>` appends.

## Challenge

```sh
printf '%s\n' logs csv configs
```
