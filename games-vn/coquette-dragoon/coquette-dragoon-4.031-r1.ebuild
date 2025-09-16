# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="Girls love eternal mech war VN."
HOMEPAGE="https://burgeroise.itch.io/coquette-dragoon-1"
SRC_URI="coquette-dragoon-1-win-linux.zip"
S="${WORKDIR}/CoquetteDragoon-${PV}-pc"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="fetch mirror"

BDEPEND="app-arch/unzip"
