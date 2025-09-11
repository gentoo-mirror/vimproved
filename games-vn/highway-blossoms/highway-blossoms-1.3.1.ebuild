# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="A short yuri Visual Novel set in the American Southwest."
HOMEPAGE="https://vnstudioelan.itch.io/highway-blossoms"
SRC_URI="highway-blossoms-unified-zip.zip"
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

src_unpack() {
	default
	unpack "${WORKDIR}/"*.zip
}
