# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="A romance buds in cold snow."
HOMEPAGE="https://dont-touch-me.itch.io/crystal-colors"
SRC_URI="CrystalColors-pc.zip"
S="${WORKDIR}/CrystalColors-pc"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_TITLE="Crystal Colors"
