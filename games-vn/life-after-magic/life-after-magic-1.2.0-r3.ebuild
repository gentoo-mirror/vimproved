# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="lgbt+, retired magical girls in 1999"
HOMEPAGE="https://eveenova.itch.io/life-after-magic"
SRC_URI="LifeAfterMagic-${PV}-pc.zip"
S="${WORKDIR}/LifeAfterMagic-${PV}-pc"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"
