#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."

# A lightweight tag would put the commit message in the release summary.
if [[ "$(git cat-file -t "$GITHUB_REF_NAME")" != tag ]]; then
	printf '::error::Create release tags with git tag -a.\n'
	exit 1
fi

# Install fresh, so a poisoned check cache cannot change the release tools.
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew install go goreleaser

goreleaser release --clean
