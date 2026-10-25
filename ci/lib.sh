# shellcheck shell=bash
# Helpers for the ci/*.sh task scripts. Source it after cd to the repository root.

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

# _uses_mise_tools reports whether mise loaded mise.tools.toml. MISE_ENV is a comma list.
_uses_mise_tools() {
	[[ ",${MISE_ENV:-}," == *,tools,* ]]
}

# A MISE_ENV from the shell replaces the env list in .miserc.local.toml, so mise skips mise.tools.toml.
_check_mise_env() {
	_uses_mise_tools && return 0
	grep -qsE '^[[:space:]]*env[[:space:]]*=.*"tools"' .miserc.local.toml || return 0
	die "Your shell sets MISE_ENV=${MISE_ENV:-}, which overrides .miserc.local.toml. Use MISE_ENV=${MISE_ENV:+$MISE_ENV,}tools."
}

# _name_of skips a major version suffix like /v2.
_name_of() {
	local module="$1"
	local name="${module##*/}"

	if [[ "$name" =~ ^v[0-9]+$ ]]; then
		module="${module%/*}"
		name="${module##*/}"
	fi

	printf '%s\n' "$name"
}
