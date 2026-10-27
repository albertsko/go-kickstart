#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
# shellcheck source=tasks/_lib.sh
source tasks/_lib.sh

golangci-lint config verify
golangci-lint run
go mod tidy -diff
go fix -diff ./...
_files '*.sh' | _apply shellcheck
jactionlint
