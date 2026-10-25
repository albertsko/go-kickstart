#!/usr/bin/env bash
#USAGE flag "--check" help="Report formatting problems without changing files"
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
# shellcheck source=ci/lib.sh
source ci/lib.sh

[[ $# -eq 0 || "$1" == "--check" ]] || die "usage: mise run fmt [--check]"

if [[ "${1:-}" == "--check" ]]; then
	golangci-lint fmt --diff
	_files '*.sh' | _apply shfmt -d
	_files '*.md' | _apply oxfmt --check
else
	golangci-lint fmt
	_files '*.sh' | _apply shfmt -w
	_files '*.md' | _apply oxfmt
fi
