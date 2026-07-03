# Lesson 13: Processes and system inspection

## Goal

Inspect processes, identity, operating system information, disk free space, and optional open files.

## Why this matters

Terminal work often includes checking what is running and stopping only the process you started.

## Before you start

```sh
cd sandbox
```

Use only learner-created processes in this lesson.

## Mental model

A process has a process ID, or PID. Prefer stopping a specific PID over broad name-based commands.

## Commands introduced

- `ps`
- `pgrep`
- `pkill`
- `top`
- `df`
- `whoami`
- `id`
- `uname`
- `lsof`

## Exercise 1: Smallest useful version

Inspect your identity and OS:

```sh
whoami > out/system-info.txt
id >> out/system-info.txt
uname -a >> out/system-info.txt
cat out/system-info.txt
```

## Exercise 2: Add one option

Check disk free space:

```sh
df -h . > out/disk-free.txt
cat out/disk-free.txt
```

## Exercise 3: Combine with previous knowledge

Start a learner-created process:

```sh
sleep 300 &
sleep_pid=$!
printf 'sleep pid: %s\n' "$sleep_pid" > out/sleep-process.txt
ps -p "$sleep_pid" >> out/sleep-process.txt
cat out/sleep-process.txt
```

Stop that exact process:

```sh
kill "$sleep_pid"
```

## Exercise 4: Realistic task

Run the included slow task in the background, inspect it, then stop it by PID:

```sh
scripts/slow-task.sh 300 &
task_pid=$!
ps -p "$task_pid"
kill "$task_pid"
```

## Challenge

If `lsof` exists, use it to inspect one file you open with `less`, then quit `less`.

## Common mistakes

- Stopping processes by broad name instead of exact PID.
- Leaving background `sleep` processes running.
- Treating `top` as a command that exits automatically; usually press `q`.

## GNU/Linux vs macOS notes

`ps` and `top` options differ across systems. `ps -p PID` is portable for this lesson. `lsof` may not be installed.

## Bash vs zsh notes

`$!` expands to the last background process ID in Bash and zsh.

## Check yourself

Confirm that `out/system-info.txt`, `out/disk-free.txt`, and `out/sleep-process.txt` exist.

## Next lesson

Next you will write your first Bash scripts.
