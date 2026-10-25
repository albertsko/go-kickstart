#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."

if [[ "$(git cat-file -t "$GITHUB_REF_NAME")" != tag ]]; then
	printf '::error::Create release tags with git tag -a.\n'
	exit 1
fi

goreleaser release --clean
