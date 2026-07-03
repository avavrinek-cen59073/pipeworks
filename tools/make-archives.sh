#!/usr/bin/env bash
set -euo pipefail

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
repo_root=$(CDPATH= cd -- "$script_dir/.." && pwd)
fixtures_dir=$repo_root/fixtures
archives_dir=$fixtures_dir/archives
tmp_dir=$(mktemp -d "${TMPDIR:-/tmp}/pipeworks-archives.XXXXXX")

cleanup() {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

mkdir -p "$archives_dir"
rm -f "$archives_dir"/reports-sample.tar "$archives_dir"/reports-sample.tar.gz "$archives_dir"/logs-sample.tar.gz "$archives_dir"/configs-sample.zip

mkdir -p "$tmp_dir/reports" "$tmp_dir/logs" "$tmp_dir/configs"
cp "$fixtures_dir/reports/q1.txt" "$fixtures_dir/reports/q2.txt" "$fixtures_dir/reports/summary.md" "$tmp_dir/reports/"
cp "$fixtures_dir/logs/app-2026-06-01.log" "$fixtures_dir/logs/auth.log" "$tmp_dir/logs/"
cp "$fixtures_dir/configs/app.conf" "$fixtures_dir/configs/database.conf" "$tmp_dir/configs/"

(cd "$tmp_dir" && tar -cf "$archives_dir/reports-sample.tar" reports)
(cd "$tmp_dir" && tar -czf "$archives_dir/reports-sample.tar.gz" reports)
(cd "$tmp_dir" && tar -czf "$archives_dir/logs-sample.tar.gz" logs)

if command -v zip >/dev/null 2>&1; then
  (cd "$tmp_dir" && zip -qr "$archives_dir/configs-sample.zip" configs)
  printf 'Created optional zip archive.\n'
else
  printf 'zip not found; skipped optional zip archive.\n'
fi

printf 'Archive samples are in %s\n' "$archives_dir"
