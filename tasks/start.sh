#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
# shellcheck source=tasks/_lib.sh
source tasks/_lib.sh

name="$(_name_of "$(go list -m)")"

tasks/build.sh

exec "bin/$name" "$@"
