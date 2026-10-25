#!/usr/bin/env bash
set -euo pipefail

readonly BREW="/home/linuxbrew/.linuxbrew/bin/brew"

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.."

if [[ "$(git cat-file -t "$GITHUB_REF_NAME")" != tag ]]; then
	printf '::error::Create release tags with git tag -a.\n'
	exit 1
fi

brew_env="$("$BREW" shellenv)"
eval "$brew_env"
brew install go goreleaser

goreleaser release --clean
