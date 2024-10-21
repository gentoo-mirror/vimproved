# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RENPY_LAYOUT="plain"
inherit renpy

DESCRIPTION="I Can't Believe the Most Popular Girl in School is a Lesbian, Just Like Me!"
HOMEPAGE="https://teamanpim.itch.io/i-cant-believe-the-most-popular-girl-in-school-is-a-lesbian-just-like-me"
SRC_URI="MostPopularGirlInSchoolLesLikeMe-${PV}-pc.zip"
S="${WORKDIR}/MostPopularGirlInSchoolLesLikeMe-${PV}-pc"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_TITLE="${DESCRIPTION}"
