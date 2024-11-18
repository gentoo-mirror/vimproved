# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="Anyone can be saved, but not everyone can be. A free horror Visual Novel."
HOMEPAGE="https://gbpatch.itch.io/lake-of-voices"
SRC_URI="Lake-of-Voices-${PV}-pc.zip"
S="${WORKDIR}/Lake-of-Voices-${PV}-pc"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_TITLE="Lake Of Voices"
