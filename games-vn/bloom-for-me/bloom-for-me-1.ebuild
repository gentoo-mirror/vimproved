# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="Show me how you bloom, in your darkest moment."
HOMEPAGE="https://dont-touch-me.itch.io/bloom-for-me"
SRC_URI="BloomForMe-pc.zip"
S="${WORKDIR}/BloomForMe-pc"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"

RENPY_TITLE="Bloom for me"
RENPY_WINDOW_ICON="game/gui/icon.png"
