# Solutions 13: Processes and system inspection

## Exercise 1

Task: Inspect identity and OS.

```sh
whoami > out/system-info.txt
id >> out/system-info.txt
uname -a >> out/system-info.txt
```

Why this works: each command appends another piece of system information.

## Exercise 2

Task: Check disk free space.

```sh
df -h . > out/disk-free.txt
```

Why this works: `.` asks about the filesystem containing the sandbox.

## Exercise 3

Task: Start, inspect, and stop a `sleep`.

```sh
sleep 300 &
sleep_pid=$!
printf 'sleep pid: %s\n' "$sleep_pid" > out/sleep-process.txt
ps -p "$sleep_pid" >> out/sleep-process.txt
kill "$sleep_pid"
```

Why this works: `$!` captures the last background PID so you can target that exact process.

## Exercise 4

Task: Run and stop the slow task by PID.

```sh
scripts/slow-task.sh 300 &
task_pid=$!
ps -p "$task_pid"
kill "$task_pid"
```

Common mistake: using broad process-name termination instead of the captured PID.

## Challenge

If available:

```sh
command -v lsof
```

Open a file with `less` in another terminal and inspect its PID with `lsof`.
