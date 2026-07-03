#!/usr/bin/env bash
set -euo pipefail

name=${1:-learner}
printf 'Hello, %s\n' "$name"
