# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} luajit )
inherit lua-single

FENNEL_LS_COMMIT="e7c642e12a15c6d452559414ee1890b30f4e8406"

DESCRIPTION="A language server for fennel."
HOMEPAGE="https://git.sr.ht/~xerool/fennel-ls"
SRC_URI="https://git.sr.ht/~xerool/fennel-ls/archive/${FENNEL_LS_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/${PN}-${FENNEL_LS_COMMIT}"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/fennel"

src_compile() {
	emake FENNEL=fennel LUA="${ELUA}"
}

src_install() {
	emake DESTDIR="${ED}" PREFIX="/usr" install
}
