# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="Protagonist must prove she's not in love (she is)."
HOMEPAGE="https://omure.itch.io/the-lying-maid"
SRC_URI="tsunmeido-${PV}-pc.zip"
S="${WORKDIR}/tsunmeido-${PV}-pc"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_TITLE="The Vampire(?) Detective and the Case of the Lying Maid"
