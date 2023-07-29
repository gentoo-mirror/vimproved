# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} luajit )
inherit lua-single

DESCRIPTION="A language server for fennel."
HOMEPAGE="https://git.sr.ht/~xerool/fennel-ls"
FENNEL_LS_COMMIT="e7c642e12a15c6d452559414ee1890b30f4e8406"
SRC_URI="https://git.sr.ht/~xerool/fennel-ls/archive/${FENNEL_LS_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/fennel-ls-${FENNEL_LS_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${LUA_REQUIRED_USE}"
DEPEND="${LUA_DEPS}"
RDEPEND="${DEPEND}"

src_compile() {
	emake LUA="${ELUA}"
}

src_install() {
	emake PREFIX="${ED}/usr" install
}
