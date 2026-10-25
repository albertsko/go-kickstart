#!/usr/bin/env bash
set -euo pipefail

readonly BREW="/home/linuxbrew/.linuxbrew/bin/brew"

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."

# eval alone would hide a missing brew.
brew_env="$("$BREW" shellenv)"
eval "$brew_env"
printf '%s\n' "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" >>"$GITHUB_PATH"

# mise comes from the Brewfile, so this script calls brew directly.
# Cleanup prunes the restored cache to the Brewfile, so it runs only in CI.
brew bundle --file ci/Brewfile
brew bundle cleanup --force --file ci/Brewfile

# The key names the installed versions, so CI saves a new cache only when a tool changed.
versions="$( (brew list --formula --versions && brew list --cask --versions) | git hash-object --stdin)"
printf 'key=brew-v2-%s-%s-%s\n' "$RUNNER_OS" "$RUNNER_ARCH" "$versions" >>"$GITHUB_OUTPUT"
