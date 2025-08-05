# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RENPY_OVERRIDE_TITLE="National Park Girls: Love Our Parks Edition"
RENPY_USE_PRECOMPILED=1

inherit renpy

DESCRIPTION="All 5 episodes of National Park Girls in one release with improvements!"
HOMEPAGE="https://vnstudioelan.itch.io/national-park-girls-complete"
SRC_URI="${P}.zip"
S="${WORKDIR}/National Park Girls Love Our Parks Edition ${PV} - Unified"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"

RENPY_WINDOW_ICON="game/AppIcon.png"

pkg_nofetch() {
	einfo "Please buy and download"
	einfo "\"National Park Girls Love Our Parks Edition ${PV} - Unified [F8BAC409].zip\" from:"
	einfo " ${HOMEPAGE}"
	einfo "and rename it to ${P}.zip, then"
	einfo "move it to your distfiles directory."
}
