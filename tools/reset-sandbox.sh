#!/usr/bin/env bash
set -euo pipefail

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
repo_root=$(CDPATH= cd -- "$script_dir/.." && pwd)
fixtures_dir=$repo_root/fixtures
sandbox_dir=$repo_root/sandbox
assume_yes=0

usage() {
  printf 'Usage: %s [--yes]\n' "${0##*/}"
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --yes|-y)
      assume_yes=1
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      printf 'Unknown option: %s\n' "$1" >&2
      usage >&2
      exit 2
      ;;
  esac
  shift
done

if [ ! -d "$fixtures_dir" ]; then
  printf 'Missing fixtures directory: %s\n' "$fixtures_dir" >&2
  exit 1
fi

case "$sandbox_dir" in
  "$repo_root"/sandbox) ;;
  *)
    printf 'Refusing unsafe sandbox path: %s\n' "$sandbox_dir" >&2
    exit 1
    ;;
esac

if [ -e "$sandbox_dir" ] && [ "$assume_yes" -ne 1 ]; then
  printf 'This will rebuild %s from fixtures.\n' "$sandbox_dir"
  printf 'Files outside sandbox/out may be replaced. Continue? [y/N] '
  read -r answer
  case "$answer" in
    y|Y|yes|YES) ;;
    *)
      printf 'Reset cancelled.\n'
      exit 0
      ;;
  esac
fi

tmp_out=
if [ -d "$sandbox_dir/out" ]; then
  tmp_out=$(mktemp -d "${TMPDIR:-/tmp}/pipeworks-out.XXXXXX")
  cp -R "$sandbox_dir/out/." "$tmp_out/"
fi

rm -rf "$sandbox_dir"
mkdir -p "$sandbox_dir"
for item in README.md logs csv json configs reports archives scripts messy; do
  if [ -e "$fixtures_dir/$item" ]; then
    cp -R "$fixtures_dir/$item" "$sandbox_dir/"
  fi
done
mkdir -p "$sandbox_dir/out"

if [ -n "$tmp_out" ]; then
  cp -R "$tmp_out/." "$sandbox_dir/out/"
  rm -rf "$tmp_out"
fi

if [ ! -f "$sandbox_dir/out/README.md" ]; then
  printf '# sandbox/out\n\nWrite lesson output files here. You can delete these outputs and recreate them while practicing.\n' > "$sandbox_dir/out/README.md"
fi

printf 'Sandbox reset complete: %s\n' "$sandbox_dir"
