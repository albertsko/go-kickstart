#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
# shellcheck source=tasks/_lib.sh
source tasks/_lib.sh

command -v brew >/dev/null || die "Homebrew is missing. Install the tools with: mise install"
brew bundle --file tasks/ci/Brewfile "$@"
