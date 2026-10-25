#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
# shellcheck source=tasks/_lib.sh
source tasks/_lib.sh

[[ $# -eq 0 || "$1" == "--check" ]] || die "usage: mise run fmt [--check]"

go_fmt=(golangci-lint fmt)
sh_fmt=(shfmt -w)
md_fmt=(oxfmt)

if [[ "${1:-}" == "--check" ]]; then
	go_fmt+=(--diff)
	sh_fmt=(shfmt -d)
	md_fmt+=(--check)
fi

"${go_fmt[@]}"
_files '*.sh' | _apply "${sh_fmt[@]}"
_files '*.md' | _apply "${md_fmt[@]}"
