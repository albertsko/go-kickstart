#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
printf '%s\n' "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" >>"$GITHUB_PATH"

# brew autoremove drops dependencies left over from an older cache.
./run brew
brew autoremove
