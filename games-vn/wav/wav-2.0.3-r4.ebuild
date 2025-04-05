# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="a dark fantasy yuri visual novel"
HOMEPAGE="https://l3.itch.io/wav"
SRC_URI="Without-a-Voice-${PV}-Unified.zip"
S="${WORKDIR}/Without a Voice ${PV} - Unified"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"

RENPY_WINDOW_ICON="game/AppIcon.png"

PATCHES=(
	"${FILESDIR}/wav-2.0.3-endings-syntax.patch"
	"${FILESDIR}/wav-2.0.3-isMelanieInternal.patch"
)
