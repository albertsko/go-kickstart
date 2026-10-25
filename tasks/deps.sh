#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
# shellcheck source=tasks/_lib.sh
source tasks/_lib.sh

export HOMEBREW_NO_AUTO_UPDATE=1
command -v brew >/dev/null && exec brew bundle check --file tasks/ci/Brewfile

mise install --dry-run-code >/dev/null || die "Some tools in mise.toml are missing. Run: mise install"
printf 'The tools in mise.toml are installed.\n'
