# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RENPY_TITLE="Amelie"
inherit renpy

DESCRIPTION="In the middle of a field, far out in the countryside, sits a lone manor."
HOMEPAGE="https://twoandahalfstudios.itch.io/amelie"
SRC_URI="Amelie.zip"
S="${WORKDIR}"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"
