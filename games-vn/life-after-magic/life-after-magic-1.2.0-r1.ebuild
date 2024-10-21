# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="lgbt+, retired magical girls in 1999"
HOMEPAGE="https://eveenova.itch.io/life-after-magic"
SRC_URI="LifeAfterMagic-${PV}-pc.zip"
S="${WORKDIR}/LifeAfterMagic-${PV}-pc"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_TITLE="Life After Magic"
