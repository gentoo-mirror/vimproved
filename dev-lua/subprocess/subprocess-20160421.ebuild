# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-1 luajit )
inherit lua

DESCRIPTION="A Lua module to create child processes and communicate with them."
HOMEPAGE="https://github.com/xlq/lua-subprocess"
SUBPROCESS_COMMIT="b5f84612acb625a0b564aa50f18614180a2a404e"
SRC_URI="https://github.com/xlq/lua-subprocess/archive/${SUBPROCESS_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/lua-subprocess-${SUBPROCESS_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="${LUA_DEPS}"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

lua_src_compile() {
	emake INSTALL_CMOD="$(lua_get_cmod_dir)"
}

src_compile() {
	lua_foreach_impl lua_src_compile
}

lua_src_install() {
	mkdir -p "${ED}$(lua_get_cmod_dir)" || die
	emake INSTALL_CMOD="${ED}$(lua_get_cmod_dir)" install
}

src_install() {
	lua_foreach_impl lua_src_install
}
