# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: zig.eclass
# @MAINTAINER:
# Violet Purcell <vimproved@inventati.org>
# @AUTHOR:
# Violet Purcell <vimproved@inventati.org>
# @SUPPORTED_EAPIS: 8
# @BLURB: Common eclass for programs written in the Zig programming language.
# @DESCRIPTION:
# This eclass contains helper code for any package with code written in Zig.

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ ! ${_ZIG_ECLASS} ]]; then
_ZIG_ECLASS=1

inherit edo

# @ECLASS_VARIABLE: ZIG
# @DESCRIPTION:
# The Zig binary to use for build. Useful if you have multiple Zig versions
# installed and want to use a specific version.
: "${ZIG:-}"

# @ECLASS_VARIABLE: ZIG_MIN
# @PRE_INHERIT
# @DEFAULT_UNSET
# @DESCRIPTION:
# Specifies the minimum version of Zig (inclusive). Must be a minor version
# (x.y).
: "${ZIG_MIN:-}"

# @ECLASS_VARIABLE: ZIG_MAX
# @PRE_INHERIT
# @DEFAULT_UNSET
# @DESCRIPTION:
# Specifies the maximum version of Zig (exclusive). Must be a minor version
# (x.y).
: "${ZIG_MAX:-}"

BDEPEND="|| (
	dev-lang/zig
	dev-lang/zig-bin
)"

if [[ -n "${ZIG_MIN}" ]]; then
	BDEPEND+=" || (
		>=dev-lang/zig-${ZIG_MIN}
		>=dev-lang/zig-bin-${ZIG_MIN}
	)"
fi

if [[ -n "${ZIG_MAX}" ]]; then
	BDEPEND+=" || (
		<dev-lang/zig-${ZIG_MAX}
		<dev-lang/zig-bin-${ZIG_MAX}
	)"
fi

# @FUNCTION: zig-set_ZIG
# @DESCRIPTION:
# Sets the ZIG environment variable.
zig-set_ZIG() {
	# Exit if ZIG is already set by the user or the ebuild.
	[[ -n ${ZIG} ]] && return

	# Determine suitable Zig version. Will select the highest minor version
	# that's less than ZIG_MAX.
	local candidate selected selected_ver ver

	for candidate in "${BROOT}"/usr/bin/zig-*; do
		if [[ ! -L ${candidate} || ${candidate} != */zig?(-bin)-+([0-9.]) ]]; then
			continue
		fi

		ver=${candidate##*-}

		ver_minor=${ver%.*}

		if [[ -n ${ZIG_MIN} ]] \
			&& ver_test "${ver_minor}" -lt "${ZIG_MIN}"; then
			continue
		fi

		if [[ -n ${ZIG_MAX} ]] \
			&& ver_test "${ver_minor}" -ge "${ZIG_MAX}"; then
			continue
		fi

		if [[ -n ${selected_ver} ]] \
			&& ver_test "${selected_ver}" -gt "${ver_minor}"; then
			continue
		fi

		selected="${candidate}"
		selected_ver="${ver}"
	done

	if [[ -z ${selected} ]]; then
		die "Could not find (suitable) zig installation in ${BROOT}/usr/bin"
	fi

	export ZIG="${selected}"
	export ZIG_VER="${selected_ver}"
}

# @FUNCTION: zig_pkg_setup
# @DESCRIPTION:
# Determines suitable Zig installation and exports ZIG.
zig_pkg_setup() {
	zig-set_ZIG
	mkdir -p "${T}/zig-cache" || die
	export ZIG_GLOBAL_CACHE_DIR="${T}/zig-cache"
}

EXPORT_FUNCTIONS pkg_setup

fi
