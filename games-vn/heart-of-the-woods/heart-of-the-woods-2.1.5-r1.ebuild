# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="A yuri VN about a love between two girls that transcends life and death."
HOMEPAGE="https://vnstudioelan.itch.io/heart-of-the-woods"
SRC_URI="Heart_of_the_Woods_${PV}_Unified_[5630C1F1].zip"
S="${WORKDIR}/Heart of the Woods ${PV} - Unified"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"

PATCHES=(
	"${FILESDIR}/heart-of-the-woods-2.1.5-newer-renpy.patch"
)

RENPY_WINDOW_ICON="game/AppIcon.png"

pkg_nofetch() {
	einfo "Please buy and download"
	einfo "\"Heart of the Woods ${PV} - Unified [5630C1F1].zip\" from:"
	einfo " ${HOMEPAGE}"
	einfo "and rename it to Heart_of_the_Woods_${PV}_Unified_[5630C1F1].zip, then"
	einfo "move it to your distfiles directory."
}
