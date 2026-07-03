#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 1 ]; then
  printf 'Usage: %s LOGFILE\n' "${0##*/}" >&2
  exit 2
fi

grep 'level=ERROR' "$1"
