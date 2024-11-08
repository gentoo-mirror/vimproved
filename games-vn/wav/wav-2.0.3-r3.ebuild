# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="a dark fantasy yuri visual novel"
HOMEPAGE="https://l3.itch.io/wav"
SRC_URI="Without-a-Voice-${PV}-Unified.zip"
S="${WORKDIR}/Without a Voice ${PV} - Unified"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_WINDOW_ICON="game/AppIcon.png"
RENPY_TITLE="Without a Voice"

PATCHES=(
	"${FILESDIR}/wav-2.0.3-endings-syntax.patch"
	"${FILESDIR}/wav-2.0.3-isMelanieInternal.patch"
)
