#!/usr/bin/env bash
set -euo pipefail

seconds=${1:-5}
printf 'Starting slow task for %s seconds\n' "$seconds"
sleep "$seconds"
printf 'Done\n'
