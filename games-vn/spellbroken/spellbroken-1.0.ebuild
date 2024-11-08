# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="A Sci-Fantasy Adventure Yuri VN"
HOMEPAGE="https://punishedhag.itch.io/spellbroken"
SRC_URI="Spellbroken-${PV}-linux.tar.bz2"
S="${WORKDIR}/Spellbroken-${PV}-linux"

KEYWORDS="~amd64"

RENPY_TITLE="Spellbroken"
