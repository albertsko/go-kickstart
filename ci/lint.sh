#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
# shellcheck source=ci/lib.sh
source ci/lib.sh

golangci-lint run
go mod tidy -diff
go fix -diff ./...
_files '*.sh' | _apply shellcheck
jactionlint
