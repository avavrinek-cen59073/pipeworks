# Pipeworks

Pipeworks is a hands-on terminal and shell course inspired by `vimtutor`: you learn by doing real work in a real terminal against local files.

There is no web app, Docker container, SSH server, sudo step, paid service, or external infrastructure. Clone or download the repository, reset the sandbox, open a lesson, and practice.

## Who this is for

Pipeworks is for learners who want practical terminal fluency:

- beginners who know a few commands but do not yet feel comfortable moving around;
- developers who want stronger text-processing and automation skills;
- operators, data workers, and support engineers who inspect logs and files;
- anyone who wants to understand pipelines instead of copying one-liners.

The course starts with fundamentals, then builds toward real-world work: search, file discovery, disk usage, pipelines, `sed`, `awk`, `xargs`, archives, process inspection, scripts, debugging, and integrated shell workflows.

## How Pipeworks differs from normal tutorials

Most tutorials show commands in isolation. Pipeworks gives you a local working area with realistic logs, CSV files, configs, reports, scripts, archives, and messy filenames. Lessons ask you to run commands, inspect output, save results, compare behavior, and recover safely.

You will repeatedly practice checking where you are, previewing destructive operations, quoting paths and variables, combining small tools with pipes, writing output to `sandbox/out/`, and reading command help, manual pages, and errors.

## Requirements

Use GNU/Linux or macOS with a normal terminal. You need common command-line tools that are already present on most systems: `bash`, `grep`, `sed`, `awk`, `find`, `du`, `sort`, `uniq`, `cut`, `tr`, `wc`, `xargs`, `tar`, and `gzip`. Optional tools include `zsh`, `zip`, `unzip`, `shellcheck`, and `lsof`.

No package installation is required for the main course.

## Start

```sh
git clone git@github.com:avavrinek-cen59073/pipeworks.git
cd pipeworks
./tools/doctor.sh
./tools/reset-sandbox.sh
cd sandbox
```

Do not use a fake real GitHub URL in your notes or scripts. Replace `<repo-url>` only when you know the real repository URL.

## Repository layout

```text
lessons/    Markdown lessons
solutions/  Full worked solutions
fixtures/   Clean source data used to rebuild the sandbox
sandbox/    Your working copy for exercises
checks/     Optional lightweight check scripts
tools/      Setup, reset, and archive helper scripts
```

`fixtures/` is the clean source of truth. `sandbox/` is where you practice. You can damage files in `sandbox/` and reset them at any time.

## Reset the sandbox

From the repository root:

```sh
./tools/reset-sandbox.sh
```

For non-interactive use:

```sh
./tools/reset-sandbox.sh --yes
```

The reset script rebuilds `sandbox/` from `fixtures/` and recreates `sandbox/out/`. It warns before replacing sandbox changes unless you pass `--yes`.

## Use lessons

Open lessons in order:

```sh
less lessons/00-setup.md
```

Most lessons tell you to run commands from:

```sh
cd sandbox
```

Exercises are intentionally small at first. Later lessons combine earlier tools into realistic workflows.

## Use solutions

Solutions live in `solutions/` and match lesson numbers. Try the exercise first, then read the solution:

```sh
less solutions/04-grep-searching-text.md
```

Solutions show one recommended command, explain why it works, and mention common mistakes or alternatives where useful.

## Optional checks

Some lessons have check scripts. They inspect files you create under `sandbox/out/`.

```sh
./checks/check-04-grep-searching-text.sh
```

Checks are optional. They are small Bash scripts, not a test framework.

## GNU/Linux and macOS notes

Most lessons use portable command patterns, but some tools differ:

```sh
# GNU/Linux
du -h --max-depth=1 .

# macOS/BSD
du -h -d 1 .
```

```sh
# GNU/Linux
sed -i 's/old/new/g' file

# macOS/BSD
sed -i '' 's/old/new/g' file
```

Pipeworks avoids requiring GNU-only flags such as `grep -P`, `readlink -f`, `stat -c`, and `date -d` unless alternatives are shown.

## Bash and zsh notes

Interactive command examples work in Bash and zsh unless a lesson says otherwise. External commands such as `grep`, `sort`, and `awk` behave mostly the same; shell syntax and glob behavior can differ.

Scripts in this repository use Bash:

```sh
#!/usr/bin/env bash
```

Running a Bash script from zsh is fine when the script has a Bash shebang and executable permissions.

## Safety notes

Pipeworks repeatedly teaches safe habits: work inside `sandbox/`, run `pwd` before batch operations, preview before deleting or moving files, copy files before editing them in place, quote paths and variables, handle filenames with spaces, avoid `sudo`, and avoid random internet install commands.

Treat these as danger signs until you understand the exact target:

```sh
rm -rf
find ... -delete
sed -i
xargs rm
pkill
```

Prefer previews:

```sh
find messy -name '*.tmp' -print
find messy -name '*.tmp' -print0 | xargs -0 echo rm
```
