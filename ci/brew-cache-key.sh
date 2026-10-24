#!/usr/bin/env bash
set -euo pipefail

# The key changes daily, so the cache picks up new tool versions.

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."

prefix="brew-v1-${RUNNER_OS}-${RUNNER_ARCH}-$(git hash-object ci/Brewfile)-"
printf 'restore-prefix=%s\n' "$prefix" >>"$GITHUB_OUTPUT"
printf 'key=%s%s\n' "$prefix" "$(date -u +%F)" >>"$GITHUB_OUTPUT"
