#!/usr/bin/env bash

die() {
	printf 'Error: %s\n' "$1" >&2
	exit 1
}

_name_of() {
	local module="$1"

	[[ "${module##*/}" =~ ^v[0-9]+$ ]] && module="${module%/*}"
	printf '%s\n' "${module##*/}"
}
