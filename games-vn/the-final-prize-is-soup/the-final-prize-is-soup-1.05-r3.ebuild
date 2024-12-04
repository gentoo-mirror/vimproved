# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="A survival-horror yuri visual novel."
HOMEPAGE="https://4noki.itch.io/the-final-prize-is-soup"
SRC_URI="the-final-prize-is-soup-win-linux.zip"
S="${WORKDIR}/finalsoup-${PV}-pc"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"

RENPY_TITLE="The Final Prize is Soup"
