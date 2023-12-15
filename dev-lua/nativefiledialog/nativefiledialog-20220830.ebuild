# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua5-{1..4} luajit )
inherit flag-o-matic lua

DESCRIPTION="Lua library that portably invokes native file open and save dialogs."
HOMEPAGE="https://github.com/Vexatos/nativefiledialog"
NATIVEFILEDIALOG_COMMIT="bea4560b9269bdc142fef946ccd8682450748958"
SRC_URI="https://github.com/Vexatos/nativefiledialog/archive/${NATIVEFILEDIALOG_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/nativefiledialog-${NATIVEFILEDIALOG_COMMIT}/"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${LUA_REQUIRED_USE}"

RDEPEND="
	${LUA_DEPS}
	x11-libs/gtk+:3
"
DEPEND="${RDEPEND}"

lua_src_compile() {
	append-flags "-fPIC"
	emake -f lua/Makefile.linux \
		LIBFLAG="-shared ${LDFLAGS}" \
		LUA_INCDIR="$(lua_get_include_dir)" \
		LUA_LIBDIR="/usr/$(get_libdir)"
}

src_compile() {
	lua_foreach_impl lua_src_compile
}

lua_src_install() {
	mkdir -p "${ED}$(lua_get_cmod_dir)" || die
	emake -f lua/Makefile.linux INST_LIBDIR="${ED}$(lua_get_cmod_dir)" install
}

src_install() {
	lua_foreach_impl lua_src_install
}
