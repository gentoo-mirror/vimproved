# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )
inherit python-single-r1 renpy

DESCRIPTION="This world is woven of strings, of fate and of hate."
HOMEPAGE="https://4noki.itch.io/lachesis-or-atropos"
SRC_URI="lachesis-or-atropos-win-linux.zip"
S="${WORKDIR}/lachesisoratropos-${PV}-pc"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

RDEPEND="$(python_gen_cond_dep 'dev-python/discord-rpc-py[${PYTHON_USEDEP}]')"
BDEPEND="app-arch/unzip"

PATCHES=(
	"${FILESDIR}/lachesis-or-atropos-1.20-reset-transformations.patch"
)

RENPY_TITLE="Lachesis or Atropos"

src_prepare() {
	renpy_src_prepare
	rm -r game/python-packages || die
}
