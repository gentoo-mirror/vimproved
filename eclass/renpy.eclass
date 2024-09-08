# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: renpy.eclass
# @MAINTAINER:
# Violet Purcell <vimproved@inventati.org>
# @AUTHOR:
# Violet Purcell <vimproved@inventati.org>
# @SUPPORTED_EAPIS: 8
# @BLURB: Eclass for Visual Novels made with games-engines/renpy.
# @DESCRIPTION:
# This eclass contains functions for installing Visual Novels made with
# games-engines/renpy. It installs the renpy data files, and then replaces
# the bundled renpy with a symlink to the system renpy. Finally, it creates
# wrapper scripts and a desktop entry to run the VN.

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

# @ECLASS_VARIABLE: RENPY_TITLE
# @DESCRIPTION:
# The title of the VN to be used in the desktop entry. Defaults to ${PN}.
: "${RENPY_TITLE:="${PN}"}"

# @ECLASS_VARIABLE: RENPY_LAYOUT
# @PRE_INHERIT
# @DESCRIPTION:
# The layout of the renpy VN. Set to "archive" for newer VNs that store data in
# an rpa archive. Set to "plain" for older VNs that store assets uncompressed.
# Defaults to "archive".
: "${RENPY_LAYOUT:=archive}"

# @ECLASS_VARIABLE: RENPY_WINDOW_ICON
# @DEFAULT_UNSET
# @DESCRIPTION:
# Overrides the path to the menu icon for installation.

if [[ ! ${_RENPY_ECLASS} ]]; then
_RENPY_ECLASS=1

# @ECLASS_VARIABLE: PYTHON_COMPAT
# @INTERNAL
# @DESCRIPTION:
# This is the PYTHON_COMPAT variable.
PYTHON_COMPAT=( python3_{11..13} )

inherit desktop python-single-r1 xdg

LICENSE="all-rights-reserved"
SLOT="0"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="bindist fetch splitdebug test"

RDEPEND="
	games-engines/renpy[${PYTHON_SINGLE_USEDEP}]
	${PYTHON_DEPS}
"
[[ "${RENPY_LAYOUT}" = archive ]] && BDEPEND="games-util/rpatool"

# @FUNCTION: renpy_pkg_nofetch
# @DESCRIPTION:
# This is the renpy_pkg_nofetch function.
renpy_pkg_nofetch() {
	einfo "Please buy and download ${SRC_URI} from:"
	einfo " ${HOMEPAGE}"
	einfo "and move it to your distfiles directory"
}

# @FUNCTION: renpy_src_prepare
# @DESCRIPTION:
# This is the renpy_src_prepare function.
renpy_src_prepare() {
	if [[ "${RENPY_LAYOUT}" = archive ]]; then
		mkdir "${T}/unpacked" || die
		pushd "${T}/unpacked" > /dev/null || die
		rpatool -x "${S}/game/archive.rpa" || die
		popd > /dev/null || die
	fi

	default
}

# @FUNCTION: renpy_src_install:
# @DESCRIPTION:
# This is the renpy_src_install function.
renpy_src_install() {
	insinto "/opt/${PN}"
	doins -r game

	dosym "$(python_get_sitedir)/renpy" "/opt/${PN}/renpy"
	dosym "$(python_get_scriptdir)/renpy" "/opt/${PN}/${PN}"

	local window_icon="${S}/game/gui/window_icon.png"
	[[ "${RENPY_LAYOUT}" = archive ]] && window_icon="${T}/unpacked/gui/window_icon.png"
	[[ -n "${RENPY_WINDOW_ICON}" ]] && window_icon="${RENPY_WINDOW_ICON}"

	newicon -s 256 "${window_icon}" "${PN}.png"
	make_desktop_entry "/opt/${PN}/${PN}" "${RENPY_TITLE}"
}

fi

EXPORT_FUNCTIONS pkg_nofetch src_prepare src_install
