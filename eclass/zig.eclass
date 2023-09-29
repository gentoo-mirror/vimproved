# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: zig.eclass
# @MAINTAINER:
# Violet Purcell <vimproved@inventati.org>
# @AUTHOR:
# Violet Purcell <vimproved@inventati.org>
# @SUPPORTED_EAPIS: 8
# @BLURB: Utility functions for packages using Zig's build system.
# @DESCRIPTION:
# Utility eclass for packages that use Zig's build system (eg. with build.zig).

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ ! ${_ZIG_ECLASS} ]]; then
_ZIG_ECLASS=1

inherit edo

# @ECLASS_VARIABLE: ZIG_USE_PIE
# @PRE_INHERIT
# @DESCRIPTION:
# If true, add the pie USE flag to the package. Toggle off only if the
# program is broken with PIE.
ZIG_USE_PIE="${ZIG_USE_PIE:=true}"

if [[ "${ZIG_USE_PIE}" = true ]]; then
	IUSE="pie"
fi

# @ECLASS_VARIABLE: ZIG
# @DESCRIPTION:
# The Zig binary to use for build. Useful if you have multiple Zig versions
# installed and want to use a specific version.
ZIG="${ZIG:-}"

# @ECLASS_VARIABLE: ezigargs
# @DEFAULT_UNSET
# @DESCRIPTION:
# Optional Zig arguments as Bash array; this should be defined before calling
# zig_src_compile

# @ECLASS_VARIABLE: MYZIGARGS
# @USER_VARIABLE
# @DESCRIPTION:
# User-controlled variable containing extra arguments to be passed to
# `zig build`.

# @ECLASS_VARIABLE: ZIG_BUILD_VERBOSE
# @DESCRIPTION:
# If non-empty, build with verbose output.
ZIG_BUILD_VERBOSE="${ZIG_BUILD_VERBOSE:=1}"

# @ECLASS_VARIABLE: ZIG_MIN
# @DEFAULT_UNSET
# @DESCRIPTION:
# Specifies the minimum version of Zig. Must be a minor version (x.y).
ZIG_MIN="${ZIG_MIN:-}"

# @ECLASS_VARIABLE: ZIG_MAX
# @DEFAULT_UNSET
# @DESCRIPTION:
# Specifies the maximum version of Zig. Must be a minor version (x.y).
ZIG_MAX="${ZIG_MAX:-}"

BDEPEND="|| (
	dev-lang/zig
	dev-lang/zig-bin
)"

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
			&& ver_test "${ver_minor}" -gt "${ZIG_MAX}"; then
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
}

# @FUNCTION: zig_pkg_setup
# @DESCRIPTION:
# Determines suitable Zig installation and exports ZIG.
zig_pkg_setup() {
	zig-set_ZIG
}

# @FUNCTION: zig_src_compile
# @DESCRIPTION:
# Runs `zig build` with specified arguments..
zig_src_compile() {
	local zigargs=( "${ZIG}" build )

	if [[ -n "${ZIG_BUILD_VERBOSE}" ]]; then
		zigargs+=( --verbose )
	fi

	# Enable PIE if ZIG_USE_PIE is set and use flag is enabled.
	if [[ "${ZIG_USE_PIE}" = true ]]; then
		zigargs+=( -Dpie=$(usex pie true false) )
	fi

	zigargs+=(
		# Arguments from ebuild
		"${ezigargs[@]}"

		# Arguments passed to this function
		"$@"

		# Arguments from user
		"${MYZIGARGS[@]}"
	)

	edo "${zigargs[@]}"
}

# @FUNCTION: zig_src_install
# @DESCRIPTION:
# Copies Zig's default install tree to DESTDIR.
zig_src_install() {
	# Zig has no separate install/compile steps and installs to ${S}/zig-out by
	# default. We just copy this tree to ${ED} here.
	cp -a "${S}/zig-out" "${ED}/usr" || die
}

EXPORT_FUNCTIONS pkg_setup src_compile src_install

fi
