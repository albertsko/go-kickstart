#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
# shellcheck source=ci/lib.sh
source ci/lib.sh

readonly MISERC=".miserc.local.toml"

_check_mise_env

# Without Homebrew, opt in to mise tools. Never overwrite a file the developer wrote.
if ! _uses_mise_tools && ! command -v brew >/dev/null; then
	[[ ! -e "$MISERC" ]] || die "Homebrew is missing and $MISERC exists without env = [\"tools\"]. Add it, or install Homebrew."
	printf 'env = ["tools"]\n' >"$MISERC"
	printf 'Homebrew is missing, so %s now loads mise.tools.toml.\n' "$MISERC" >&2
	export MISE_ENV=tools
fi

if _uses_mise_tools; then
	mise install
else
	brew bundle --file ci/Brewfile
fi
