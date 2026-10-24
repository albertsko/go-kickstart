#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
printf '%s\n' "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" >>"$GITHUB_PATH"

# brew autoremove drops dependencies left over from an older cache.
./run brew
brew autoremove

# The key names the installed versions, so CI saves a new cache only when a tool changed.
versions="$( (brew list --formula --versions && brew list --cask --versions) | git hash-object --stdin)"
printf 'key=brew-v2-%s-%s-%s\n' "$RUNNER_OS" "$RUNNER_ARCH" "$versions" >>"$GITHUB_OUTPUT"
