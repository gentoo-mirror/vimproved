# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="Claire's got one goal - to spend time with her friend Jamie after school."
HOMEPAGE="https://gg8473.itch.io/walk-in-the-sun"
SRC_URI="WalkintheSun-${PV}-pc.zip"
S="${WORKDIR}/WalkintheSun-1.1-pc"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_WINDOW_ICON="game/window_icon.png"
RENPY_TITLE="walk in the sun"
