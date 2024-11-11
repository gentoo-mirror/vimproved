# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="an angel summons a demon. they fall in love."
HOMEPAGE="https://nomnomnami.itch.io/contract-demon"
SRC_URI="contractdemon-${PV}-pc.zip"
S="${WORKDIR}/contractdemon-${PV}-pc"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_TITLE="CONTRACT DEMON"