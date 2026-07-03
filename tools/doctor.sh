#!/usr/bin/env bash
set -u

printf 'Pipeworks doctor\n'
printf 'Repository: %s\n' "$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
printf 'SHELL: %s\n' "${SHELL:-unknown}"

if [ -n "${BASH_VERSION:-}" ]; then
  printf 'Running under Bash: %s\n' "$BASH_VERSION"
else
  printf 'Running under shell: %s\n' "${0##*/}"
fi

missing=0

check_command() {
  cmd=$1
  if command -v "$cmd" >/dev/null 2>&1; then
    printf 'OK   %s -> %s\n' "$cmd" "$(command -v "$cmd")"
  else
    printf 'WARN missing command: %s\n' "$cmd"
    missing=1
  fi
}

for cmd in bash zsh grep sed awk find du sort uniq cut tr tar gzip wc xargs printf; do
  check_command "$cmd"
done

for cmd in zip unzip shellcheck lsof; do
  if command -v "$cmd" >/dev/null 2>&1; then
    printf 'OK   optional %s -> %s\n' "$cmd" "$(command -v "$cmd")"
  else
    printf 'INFO optional command not found: %s\n' "$cmd"
  fi
done

if [ "$missing" -eq 0 ]; then
  printf 'Doctor finished: required commands were found.\n'
else
  printf 'Doctor finished with warnings. Lessons may still be usable, but some required commands were not found.\n'
fi

exit 0
