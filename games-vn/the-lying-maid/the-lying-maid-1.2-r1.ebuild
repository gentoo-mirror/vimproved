# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="Protagonist must prove she's not in love (she is)."
HOMEPAGE="https://omure.itch.io/the-lying-maid"
SRC_URI="tsunmeido-${PV}-pc.zip"
S="${WORKDIR}/tsunmeido-${PV}-pc"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"
