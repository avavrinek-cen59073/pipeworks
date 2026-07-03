# Contributing to Pipeworks

Pipeworks is intentionally simple: Markdown lessons, local fixture data, optional check scripts, and Bash helper tools.

## Local workflow

```sh
./tools/doctor.sh
./tools/make-archives.sh
./tools/reset-sandbox.sh --yes
```

Run shell syntax checks before sending changes:

```sh
find tools checks fixtures/scripts -name '*.sh' -print0 | xargs -0 -n 1 bash -n
```

## Lesson style

- Start with a practical goal.
- Teach one idea at a time.
- Use realistic files from `sandbox/`.
- Ask learners to inspect output before saving it.
- Put complete answers in `solutions/`, not in the lesson body.
- Include GNU/Linux and macOS differences when flags differ.
- Mark Bash-specific syntax clearly.

## Data style

Fixtures should be fake but realistic. Do not include real credentials, private hostnames, customer data, or copied proprietary logs.

Keep `fixtures/` as the source of truth. Rebuild `sandbox/` with `tools/reset-sandbox.sh`.

## Check script style

Checks should be readable Bash scripts. They should validate files under `sandbox/out/`, print clear pass/fail messages, and avoid external dependencies beyond common POSIX tools and Bash.

## Safety

Do not add lessons that require `sudo`, internet installation commands, destructive commands outside `sandbox/`, or paid services.
