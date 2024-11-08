# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="Alice, Alice, the Red Queen is missing."
HOMEPAGE="https://4noki.itch.io/who-is-the-red-queen"
SRC_URI="who-is-the-red-queen-win-linux.zip"
S="${WORKDIR}/WhoIsTheRedQueen-${PV}-pc"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_TITLE="Who Is the Red Queen?"
