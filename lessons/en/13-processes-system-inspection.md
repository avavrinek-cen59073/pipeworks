# Lesson 13: Processes and system inspection

## Goal

Inspect basic system information, start a harmless background process, find it by PID, and stop only that process.

## Why this matters

Sooner or later you will need to answer "what is running?" The safe habit is to target a specific process you understand, not kill broad groups by name.

## Before you start

Run:

```sh
cd sandbox
```

Only stop processes you start in this lesson.

## Mental model

A running program is a process. Each process has a process ID, or PID.

When you run a command with `&`, the shell starts it in the background and gives you another prompt. The special variable `$!` stores the PID of the most recent background process.

## Commands introduced

```sh
ps
pgrep
pkill
top
df
whoami
id
uname
lsof
kill
```

Command meanings:

- `whoami`: print your username.
- `id`: print user and group IDs.
- `uname -a`: print operating system/kernel information.
- `df -h PATH`: show free disk space for the filesystem containing `PATH`.
- `ps -p PID`: show information about one PID.
- `kill PID`: send the default terminate signal to one process.
- `top`: interactive process viewer; usually press `q` to quit.
- `pgrep` and `pkill`: find or signal processes by name. Use cautiously.
- `lsof`: list open files; optional on some systems.

## Exercise 1: Save identity and OS information

Run:

```sh
whoami > out/system-info.txt
id >> out/system-info.txt
uname -a >> out/system-info.txt
cat out/system-info.txt
```

Why append? These are three separate commands contributing to one file, so the second and third commands use `>>`.

## Exercise 2: Check disk free space

Run:

```sh
df -h . > out/disk-free.txt
cat out/disk-free.txt
```

What it means:

- `df` reports filesystem space, not directory size. For directory size, use `du`.
- `-h` prints human-readable units.
- `.` asks about the filesystem containing the sandbox.

## Exercise 3: Start, inspect, and stop a background process

Run:

```sh
sleep 300 &
sleep_pid=$!
printf 'sleep pid: %s\n' "$sleep_pid" > out/sleep-process.txt
ps -p "$sleep_pid" >> out/sleep-process.txt
cat out/sleep-process.txt
kill "$sleep_pid"
```

What each piece does:

- `sleep 300 &` starts a harmless process in the background.
- `sleep_pid=$!` saves its PID.
- `ps -p "$sleep_pid"` inspects only that PID.
- `kill "$sleep_pid"` stops only that process.

## Exercise 4: Inspect the included slow task

Run:

```sh
scripts/slow-task.sh 300 &
task_pid=$!
ps -p "$task_pid"
kill "$task_pid"
```

This is the same pattern with a script instead of `sleep`.

## Challenge

If `lsof` is installed, open `reports/q1.txt` with `less` in one terminal and use `lsof` from another terminal to find the open file. Quit `less` with `q`.

## When it goes wrong

- If `kill "$sleep_pid"` says "No such process", the process already exited.
- If you forget to save `$!`, start a new harmless process rather than guessing a PID.
- Avoid practicing with `pkill` on real process names. It can match more than you intended.

## Compatibility notes

`ps` and `top` have many system-specific options. This lesson uses `ps -p PID` because it is widely available. `lsof` is optional.

## Check yourself

Confirm these files exist:

```sh
out/system-info.txt
out/disk-free.txt
out/sleep-process.txt
```

## Next lesson

Next you will write your first Bash scripts.
