#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
# shellcheck source=tasks/_lib.sh
source tasks/_lib.sh

readonly TEMPLATE_MODULE="github.com/albertsko/go-kickstart"

new_module="${1:-}"

[[ -n "$new_module" ]] || die "usage: mise run init <module path>, for example github.com/you/app"
old_module="$(go list -m)"
[[ "$old_module" == "$TEMPLATE_MODULE" ]] || die "init renames the template once, and this module is already $old_module"
go mod edit -module "$new_module" -print >/dev/null || die "invalid module path: $new_module"

old_name="$(_name_of "$old_module")"
new_name="$(_name_of "$new_module")"

# shellcheck disable=SC2016
git grep -lIz -F -e "$old_module" -e "$old_name" -- . ':!tasks/init.sh' |
	OLD_MODULE="$old_module" NEW_MODULE="$new_module" OLD_NAME="$old_name" NEW_NAME="$new_name" \
		xargs -0 perl -pi -e 's/(\Q$ENV{OLD_MODULE}\E)|\Q$ENV{OLD_NAME}\E/$1 ? $ENV{NEW_MODULE} : $ENV{NEW_NAME}/ge'

[[ "$new_name" == "$old_name" ]] || git mv -- "cmd/$old_name" "cmd/$new_name"

tasks/fmt.sh

printf 'Renamed %s to %s. Review with: git diff\n' "$old_module" "$new_module" >&2

IFS=/ read -r -a parts <<<"$new_module"
if ((${#parts[@]} < 3)); then
	printf 'Update the copyright holder in LICENSE.md.\n' >&2
	exit 0
fi

OWNER="${parts[1]}" YEAR="$(date +%Y)" perl -pi -e 's/^Copyright \(c\) .*$/Copyright (c) $ENV{YEAR} $ENV{OWNER}/' LICENSE.md
