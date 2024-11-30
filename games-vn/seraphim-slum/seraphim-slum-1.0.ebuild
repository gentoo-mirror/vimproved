# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="A liminal sapphic visual novel that explores just how far an angel can fall."
HOMEPAGE="https://rosesrot.itch.io/seraphim-slum"
SRC_URI="SeraphimSlum-Definitivepc.zip"
S="${WORKDIR}/SeraphimSlum-${PV}-pc"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_KEEP_COMPILED=1
RENPY_TITLE="Seraphim Slum"