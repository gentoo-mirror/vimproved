# Copyright 2025 Gentoo Authors
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

# @ECLASS_VARIABLE: RENPY_USE_PRECOMPILED
# @DEFAULT_UNSET
# @DESCRIPTION:
# Set to any value to use pre-compiled scripts/bytecode as-is instead of
# attempting to decompile/recompile.

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

inherit desktop edo wrapper xdg

RDEPEND="
	>=games-engines/renpy-8.3.4-r1
	${PYTHON_DEPS}
"
BDEPEND="
	app-arch/unrpa
	games-util/unrpyc
	media-gfx/imagemagick[png]
"

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
		edob -m "extracting ${archive}" unrpa -p game "${archive}"
	done

	if [[ -d lib ]]; then
		rm -rf lib || die
	fi

	if [[ -d renpy ]]; then
		rm -rf renpy || die
	fi

	find game -name "*.rpa" -delete || die
	if [[ -z "${RENPY_USE_PRECOMPILED}" ]]; then
		while IFS="" read -d $'\0' -r file; do
			if ! [[ -f "${file/.rpyc/.rpy}" ]]; then
				edob -m "decompiling ${file}" unrpyc "${file}"
			fi

			rm "${file}" || die
		done < <(find "${S}" -name "*.rpyc" -print0)
		find game -name "*.rpyb" -delete || die "failed to delete Ren'Py bytecode"
	fi

	default
}

# @FUNCTION: renpy_src_compile
# @DESCRIPTION:
# Attempts to run game to compile renpy scripts.
renpy_src_compile() {
	[[ -n "${RENPY_USE_PRECOMPILED}" ]] && return

	addpredict /usr/bin/steam_appid.txt
	addpredict /usr/lib/python3.*/site-packages/renpy

	edo renpy "${S}/game" compile
	find game -name "*.bak" -delete || die "failed to delete script backups"
}

# @FUNCTION: renpy_src_install
# @DESCRIPTION:
# This is the renpy_src_install function.
renpy_src_install() {
	edo magick "${RENPY_WINDOW_ICON}" -resize 256x256 "${T}/${PN}.png"
	doicon -s 256 "${T}/${PN}.png"

	mv game "${PN}" || die "failed to move game directory"

	insinto "/usr/share/renpy"
	doins -r "${PN}"

	make_wrapper "${PN}" "renpy /usr/share/renpy/${PN}" /usr/share/renpy/${PN}
	make_desktop_entry "${PN}" "${RENPY_TITLE}"
}

fi

EXPORT_FUNCTIONS pkg_nofetch src_prepare src_compile src_install
