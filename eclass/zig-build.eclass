# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: zig-build.eclass
# @MAINTAINER:
# Violet Purcell <vimproved@inventati.org>
# @AUTHOR:
# Violet Purcell <vimproved@inventati.org>
# @SUPPORTED_EAPIS: 8
# @BLURB: Basic eclass for packages using the Zig build system.
# @DESCRIPTION:
# This eclass provides logic for packages using the Zig build system
# (build.zig).

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ ! ${_ZIG_BUILD_ECLASS} ]]; then
_ZIG_BUILD_ECLASS=1

inherit edo

# @ECLASS_VARIABLE: ZIG_USE_PIE
# @PRE_INHERIT
# @DESCRIPTION:
# If true, add the pie USE flag to the package. Toggle off only if the
# program is broken with PIE.
ZIG_USE_PIE="${ZIG_USE_PIE:=true}"

# @ECLASS_VARIABLE: ezigbuildargs
# @DEFAULT_UNSET
# @DESCRIPTION:
# Optional Zig arguments as Bash array; this should be defined before calling
# zig_src_compile

# @ECLASS_VARIABLE: MYZIGBUILDARGS
# @USER_VARIABLE
# @DESCRIPTION:
# User-controlled variable containing extra arguments to be passed to
# `zig build`.

# @ECLASS_VARIABLE: ZIG_BUILD_TYPE
# @DESCRIPTION:
# Controls Zig's build type. Can be one of Debug, ReleaseSafe, ReleaseSmall, or
# ReleaseFast. Defaults to ReleaseSafe. Only works with Zig 0.11 and later.
: "${ZIG_BUILD_TYPE:=ReleaseSafe}"

# @ECLASS_VARIABLE: ZIG_BUILD_VERBOSE
# @DESCRIPTION:
# If non-empty, build with verbose output.
: "${ZIG_BUILD_VERBOSE:=1}"

if [[ "${ZIG_USE_PIE}" = true ]]; then
	IUSE="${IUSE} pie"
fi

# @FUNCTION: zig-build_src_compile
# @DESCRIPTION:
# Runs `zig build` with specified arguments..
zig-build_src_compile() {
	local zigbuildargs=( "${ZIG}" build )

	if [[ -n "${ZIG_BUILD_VERBOSE}" ]]; then
		zigbuildargs+=( --verbose )
	fi

	# Enable PIE if ZIG_USE_PIE is set and use flag is enabled.
	if [[ "${ZIG_USE_PIE}" = true ]]; then
		zigbuildargs+=( -Dpie=$(usex pie true false) )
	fi

	if ver_test "${ZIG_VER}" -ge "0.11"; then
		zigbuildargs+=(
			# ZIG_BUILD_TYPE
			-Doptimize="${ZIG_BUILD_TYPE}"
		)
	elif [[ "${ZIG_BUILD_TYPE}" = ReleaseSafe ]]; then
			zigargs+=( -Drelease-safe )
	elif [[ "${ZIG_BUILD_TYPE}" = ReleaseFast ]]; then
			zigargs+=( -Drelease-fast )
	elif [[ "${ZIG_BUILD_TYPE}" = ReleaseSmall ]]; then
			zigargs+=( -Drelease-small )
	fi

	zigbuildargs+=(

		# Arguments from ebuild
		"${ezigbuildargs[@]}"

		# Arguments passed to this function
		"$@"

		# Arguments from user
		"${MYZIGBUILDARGS[@]}"
	)

	edo "${zigbuildargs[@]}"
}

# @FUNCTION: zig-build_src_install
# @DESCRIPTION:
# Copies Zig's default install tree to DESTDIR.
zig-build_src_install() {
	# Zig has no separate install/compile steps and installs to ${S}/zig-out by
	# default. We just copy this tree to ${ED} here.
	cp -a "${S}/zig-out" "${ED}/usr" || die
}

EXPORT_FUNCTIONS src_compile src_install

fi
