# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} luajit )

inherit lua

DESCRIPTION="A language server for fennel"
HOMEPAGE="https://git.sr.ht/~xerool/fennel-ls"
MY_PV="f4298b02be9d3af8d27bba67dc129b9a1014fc55"
SRC_URI="https://git.sr.ht/~xerool/${PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${LUA_REQUIRED_USE}"
DEPEND="${LUA_DEPS}"
RDEPEND="${DEPEND}"
BDEPEND="dev-lang/fennel"

src_install() {
	emake PREFIX="${ED}/usr" install
}
