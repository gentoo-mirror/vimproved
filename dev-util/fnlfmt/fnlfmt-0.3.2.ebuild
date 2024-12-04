# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-1 luajit lua5-{3..4} )

inherit lua-single

DESCRIPTION="A formatter for Fennel code"
HOMEPAGE="https://git.sr.ht/~technomancy/fnlfmt"
SRC_URI="https://git.sr.ht/~technomancy/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${LUA_REQUIRED_USE}"
RESTRICT="test"

DEPEND="${LUA_DEPS}"
RDEPEND="${DEPEND}"

src_compile() {
	emake LUA="${ELUA}"
}

src_install() {
	emake LUA="${ELUA}" DESTDIR="${ED}" PREFIX="/usr" install
}
