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

# @ECLASS_VARIABLE: EZIG
# @DESCRIPTION:
# The Zig binary to use for build. Useful if you have multiple Zig versions
# installed and want to use a specific version.
EZIG="${EZIG:-}"

# @ECLASS_VARIABLE: EZIG_BUILD_EXTRA_FLAGS
# @USER_VARIABLE
# @DESCRIPTION:
# Flags to be passed to `zig build`.

# @ECLASS_VARIABLE: EZIG_BUILD_VERBOSE
# @DESCRIPTION:
# If non-empty, build with verbose output.
EZIG_BUILD_VERBOSE="${EZIG_BUILD_VERBOSE:=1}"

# @ECLASS_VARIABLE: EZIG_MIN
# @DEFAULT_UNSET
# @DESCRIPTION:
# Specifies the minimum version of Zig.
EZIG_MIN="${EZIG_MIN:-}"

# @ECLASS_VARIABLE: EZIG_MAX
# @DEFAULT_UNSET
# @DESCRIPTION:
# Specifies the maximum version of Zig.
EZIG_MAX="${EZIG_MAX:-}"

BDEPEND="|| (
	dev-lang/zig
	dev-lang/zig-bin
)"

# @FUNCTION: ezig_build
# @DESCRIPTION:
# Runs `zig build` with the specified arguments and dies on failure.
ezig_build() {
	local use_pie
	if [[ "${ZIG_USE_PIE}" = true ]]; then
		use_pie=$(usex pie true false)
	else
		use_pie=false
	fi

	local ezig_build_flags="-Dpie=${use_pie} ${EZIG_EXTRA_FLAGS}"
	if [[ -n "${EZIG_BUILD_VERBOSE}" ]]; then
		ezig_build_flags="${ezig_build_flags} --verbose"
	fi

	edo "${EZIG}" build ${ezig_build_flags} "$@"
}

# @FUNCTION: zig-set_EZIG
# @DESCRIPTION:
# Sets the EZIG environment variable.
zig-set_EZIG() {
	[[ -n ${EZIG} ]] && return

	local candidate selected selected_ver ver

	for candidate in "${BROOT}"/usr/bin/zig-*; do
		if [[ ! -L ${candidate} || ${candidate} != */zig?(-bin)-+([0-9.]) ]]; then
			continue
		fi

		ver=${candidate##*-}

		ver_minor=${ver%.*}

		if [[ -n ${EZIG_MIN} ]] \
			&& ver_test "${ver_minor}" -lt "${EZIG_MIN}"; then
			continue
		fi

		if [[ -n ${EZIG_MAX} ]] \
			&& ver_test "${ver_minor}" -gt "${EZIG_MAX}"; then
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

	export EZIG="${selected}"
}

# @FUNCTION: zig_pkg_setup
# @DESCRIPTION:
# Determines suitable Zig installation and exports EZIG.
zig_pkg_setup() {
	zig-set_EZIG
}

# @FUNCTION: zig_src_compile
# @DESCRIPTION:
# Runs `ezig_build` with no extra arguments.
zig_src_compile() {
	ezig_build
}

# @FUNCTION: zig_src_install
# @DESCRIPTION:
# Installs all outputs of zig_src_compile.
zig_src_install() {
	# Zig doesn't have separate commands to build and install, but calling
	# ezig_build again should use zig's cache instead of completely rebuilding
	# the program.
	DESTDIR="${ED}" ezig_build --prefix /usr
}

EXPORT_FUNCTIONS pkg_setup src_compile src_install

fi
