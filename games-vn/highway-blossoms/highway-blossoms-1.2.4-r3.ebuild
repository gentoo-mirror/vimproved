# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RENPY_TITLE="Highway Blossoms"
inherit renpy

DESCRIPTION="A short yuri Visual Novel set in the American Southwest."
HOMEPAGE="https://vnstudioelan.itch.io/highway-blossoms"
SRC_URI="${PN}-unified-zip.zip"
S="${WORKDIR}/Highway Blossoms ${PV} - Unified"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_WINDOW_ICON="${S}/game/AppIcon.png"

PATCHES=(
	"${FILESDIR}/highway-blossoms-1.2.4-syntax.patch"
	"${FILESDIR}/highway-blossoms-1.2.4-version.patch"
)

src_unpack() {
	default
	unpack "${WORKDIR}"/*.zip
}
