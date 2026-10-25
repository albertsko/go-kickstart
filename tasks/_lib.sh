# shellcheck shell=bash

die() {
	printf 'Error: %s\n' "$1" >&2
	exit 1
}

_files() {
	git ls-files -z --cached --others --exclude-standard -- "$@" ':!vendor'
}

# _apply skips deleted files, and it runs nothing for an empty list.
_apply() {
	local files=()
	local f

	while IFS= read -r -d '' f; do
		[[ -e "$f" ]] || continue
		files+=("$f")
	done

	((${#files[@]} > 0)) || return 0
	"$@" "${files[@]}"
}

# _name_of skips a major version suffix like /v2.
_name_of() {
	local module="$1"

	[[ "${module##*/}" =~ ^v[0-9]+$ ]] && module="${module%/*}"
	printf '%s\n' "${module##*/}"
}
