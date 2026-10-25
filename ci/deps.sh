#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
# shellcheck source=ci/lib.sh
source ci/lib.sh

_check_mise_env

if _uses_mise_tools; then
	# mise run installs missing tools before any task starts, so this check passes after mise run deps.
	# It still fails when auto-install is off, for example with MISE_TASK_RUN_AUTO_INSTALL=0.
	mise install --dry-run-code >/dev/null || die "Some tools in mise.tools.toml are missing. Run: mise run setup"
	printf 'The tools in mise.tools.toml are installed.\n'
	exit 0
fi

command -v brew >/dev/null || die "Homebrew is missing. Run: mise run setup"
HOMEBREW_NO_AUTO_UPDATE=1 brew bundle check --file ci/Brewfile
