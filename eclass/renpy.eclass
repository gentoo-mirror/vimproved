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

# @ECLASS_VARIABLE: RENPY_WINDOW_ICON
# @DESCRIPTION:
# Path to the menu icon for installation.
: "${RENPY_WINDOW_ICON:="game/gui/window_icon.png"}"

if [[ ! ${_RENPY_ECLASS} ]]; then
_RENPY_ECLASS=1

# @ECLASS_VARIABLE: PYTHON_COMPAT
# @INTERNAL
# @DESCRIPTION:
# This is the PYTHON_COMPAT variable.
PYTHON_COMPAT=( python3_{12..13} )

inherit desktop python-single-r1 xdg

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	games-engines/renpy[${PYTHON_SINGLE_USEDEP}]
	${PYTHON_DEPS}
"
BDEPEND="app-arch/unrpa"

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
	for archive in $(find game -name "*.rpa"); do
		unrpa -p game "${archive}" || die
	done

	find game -name "*.rpa" -delete || die
	for file in $(find game -name "*.rpyc"); do
		if [[ -f "${file/.rpyc/.rpy}" ]]; then
			rm "${file}" || die
		fi
	done
	find game -name "*.rpyb" -delete || die

	default
}

# @FUNCTION: renpy_src_install:
# @DESCRIPTION:
# This is the renpy_src_install function.
renpy_src_install() {
	insinto "/usr/share/renpy/${PN}"
	doins -r game

	dosym "$(python_get_sitedir)/renpy" "/usr/share/renpy/${PN}/renpy"
	dosym "$(python_get_scriptdir)/renpy" "/usr/share/renpy/${PN}/${PN}"

	newicon -s 256 "${RENPY_WINDOW_ICON}" "${PN}.png"
	make_desktop_entry "/usr/share/renpy/${PN}/${PN}" "${RENPY_TITLE}"
}

fi

EXPORT_FUNCTIONS pkg_nofetch src_prepare src_install
