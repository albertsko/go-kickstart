#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
# shellcheck source=ci/lib.sh
source ci/lib.sh

name="$(_name_of "$(go list -m)")"

mkdir -p bin
go build -trimpath -o "bin/$name" "./cmd/$name"
