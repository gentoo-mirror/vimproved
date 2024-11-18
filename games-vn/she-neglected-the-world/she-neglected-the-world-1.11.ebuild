# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="Before the fairy picked up a disciple, the monster fell in love."
HOMEPAGE="https://4noki.itch.io/she-neglected-the-world"
SRC_URI="she-neglected-the-world-win-linux.zip"
S="${WORKDIR}/SheNeglectedTheWorld-${PV}-pc"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_TITLE="from that moment she neglected the world"
