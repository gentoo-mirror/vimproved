# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="A yuri VN about a love between two girls that transcends life and death."
HOMEPAGE="https://vnstudioelan.itch.io/heart-of-the-woods"
SRC_URI="${P}.zip"
S="${WORKDIR}/Heart of the Woods ${PV} - Unified"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

PATCHES=(
	"${FILESDIR}/heart-of-the-woods-2.1.5-newer-renpy.patch"
)

RENPY_WINDOW_ICON="game/AppIcon.png"
RENPY_TITLE="Heart of the Woods"
