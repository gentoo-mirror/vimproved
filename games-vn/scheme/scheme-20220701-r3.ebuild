# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="Yuki gets kidnapped??"
HOMEPAGE="https://milkkylemon.itch.io/yukis-4p-2"
SRC_URI="yukis4p2-linux.tar.bz2"
S="${WORKDIR}/yukis4p2-linux"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_ARCHIVE_PATH="game/images.rpa"
RENPY_TITLE="Spica, Chinatsu and Haruka's Enchanting, Marvelous, and quite frankly Elaborate quest to save their"
RENPY_TITLE+=" (cute) girlfriend!!!"
