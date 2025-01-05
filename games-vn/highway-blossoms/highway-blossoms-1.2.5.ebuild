# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RENPY_TITLE="Highway Blossoms"
inherit renpy

DESCRIPTION="A short yuri Visual Novel set in the American Southwest."
HOMEPAGE="https://vnstudioelan.itch.io/highway-blossoms"
SRC_URI="Highway_Blossoms_${PV}_Unified_[268ABFDB].zip"
S="${WORKDIR}/Highway Blossoms ${PV} - Unified"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"

RENPY_WINDOW_ICON="${S}/game/AppIcon.png"

PATCHES=(
	"${FILESDIR}/highway-blossoms-1.2.4-syntax.patch"
	"${FILESDIR}/highway-blossoms-1.2.4-version.patch"
	"${FILESDIR}/highway-blossoms-1.2.5-isMelanieInternal.patch"
)

pkg_nofetch() {
	einfo "Please buy and download"
	einfo "\"Highway Blossoms ${PV} - Unified [268ABFDB].zip\" from:"
	einfo " ${HOMEPAGE}"
	einfo "and rename it to Highway_Blossoms_${PV}_Unified_[268ABFDB].zip, then"
	einfo "move it to your distfiles directory."
}
