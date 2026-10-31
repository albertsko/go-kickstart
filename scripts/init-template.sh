#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
# shellcheck source=tasks/_lib
source tasks/_lib

readonly TEMPLATE_MODULE="github.com/albertsko/go-kickstart"
readonly MARK=$'\2'

new_module="${1:-}"

[[ -n "$new_module" ]] || die "usage: mise run ./scripts/init-template.sh <module path>, for example github.com/you/app"
old_module="$(go list -m)"
[[ "$old_module" == "$TEMPLATE_MODULE" ]] || die "init renames the template once, and this module is already $old_module"
go mod edit -module "$new_module" -print >/dev/null || die "invalid module path: $new_module"

old_name="$(_name_of "$old_module")"
new_name="$(_name_of "$new_module")"

rename_in() {
	local text

	IFS= read -r -d '' text <"$1" || true
	text="${text//"$old_module"/$MARK}"
	text="${text//"$old_name"/$new_name}"
	text="${text//"$MARK"/$new_module}"
	printf '%s' "$text" >"$1"
}

git rm -q -- scripts/init-template.sh

while IFS= read -r -d '' file; do
	rename_in "$file"
done < <(git grep -lIz -F -e "$old_module" -e "$old_name")

printf '<div align="center"><h3>%s</h3></div>\n' "$new_name" >README.md
[[ "$new_name" == "$old_name" ]] || git mv -- "cmd/$old_name" "cmd/$new_name"

tasks/fmt

printf 'Renamed %s to %s. Review with: git diff\n' "$old_module" "$new_module" >&2
printf 'For daily tool updates, enable "Allow GitHub Actions to create and approve pull requests" in Settings > Actions > General.\n' >&2
printf 'For fast security updates, enable "Dependency graph", "Dependabot alerts", and "Dependabot security updates" in Settings > Advanced Security.\n' >&2

IFS=/ read -r -a parts <<<"$new_module"
if ((${#parts[@]} < 3)); then
	printf 'Update the copyright holder in LICENSE.md.\n' >&2
	exit 0
fi

awk -v line="Copyright (c) $(date +%Y) ${parts[1]}" '/^Copyright \(c\) / { $0 = line } 1' LICENSE.md >LICENSE.md.tmp
mv -- LICENSE.md.tmp LICENSE.md
