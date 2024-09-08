# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RENPY_LAYOUT="plain"
inherit renpy

DESCRIPTION="Help Yuki get a girlfriend!!! (or maybe three?)"
HOMEPAGE="https://milkkylemon.itch.io/yukis-4p"
SRC_URI="Yuki's-4P-linux.tar.bz2"
S="${WORKDIR}/Yuki's-4P-linux"

SLOT="0"

BDEPEND+="app-arch/unzip"

RENPY_TITLE="Yuki's Palpitating, Passionate, Phenomenal, and quite frankly Proficient quest for a (hot) girlfriend!!!"
