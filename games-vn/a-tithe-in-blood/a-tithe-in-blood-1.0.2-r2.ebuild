# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RENPY_WINDOW_ICON="game/AppIcon.png"

inherit renpy

DESCRIPTION="A yuri romance visual novel about depression, grieving, and blood magic."
HOMEPAGE="https://vnstudioelan.itch.io/a-tithe-in-blood"
SRC_URI="${P}.zip"
S="${WORKDIR}/A Tithe in Blood ${PV} - Unified"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"

PATCHES=(
	"${FILESDIR}/${PN}-1.0.2-empty-blocks.patch"
	"${FILESDIR}/${PN}-1.0.2-version.patch"
)

pkg_nofetch() {
	einfo "Please buy and download"
	einfo "\"A Tithe in Blood ${PV} - Unified [7D368313].zip\" from:"
	einfo " ${HOMEPAGE}"
	einfo "and rename it to ${P}.zip, then"
	einfo "move it to your distfiles directory."
}
