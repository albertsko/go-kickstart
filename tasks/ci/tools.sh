#!/usr/bin/env bash
set -euo pipefail

readonly BREW="/home/linuxbrew/.linuxbrew/bin/brew"

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.."

brew_env="$("$BREW" shellenv)"
eval "$brew_env"
printf '%s\n' "$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" >>"$GITHUB_PATH"

brew bundle --file tasks/ci/Brewfile
brew bundle cleanup --force --file tasks/ci/Brewfile

versions="$( (brew list --formula --versions && brew list --cask --versions) | git hash-object --stdin)"
printf 'key=brew-v2-%s-%s-%s\n' "$RUNNER_OS" "$RUNNER_ARCH" "$versions" >>"$GITHUB_OUTPUT"
