# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit ninja-utils prefix toolchain-funcs

DESCRIPTION="Lua language server"
HOMEPAGE="https://github.com/LuaLS/lua-language-server"
SRC_URI="https://github.com/LuaLS/${PN}/releases/download/${PV}/${P}-submodules.zip -> ${P}.zip"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

BDEPEND="
	app-alternatives/ninja
	app-arch/unzip
"
RESTRICT="!test? ( test )"

PATCHES=( "${FILESDIR}/${PN}-3.10.6-libcxx-19.patch" )

src_prepare() {
	# Remove hardcoded gcc references
	sed -i "/lm.cxx/a lm.cc = '$(tc-getCC)'" \
		make.lua || die
	sed -i "s/CC = gcc/ CC = ${tc-getCC}/" \
		3rd/lpeglabel/makefile || die

	default

	# Shipped file doesn't respect CFLAGS/CXXFLAGS/LDFLAGS
	sed -i -e "s/^cc = gcc/cc = $(tc-getCC)/" \
		-e "s/^ar = ar/ar = $(tc-getAR)/" \
		-e "s/-std=c11 -O2 -Wall/-std=c11 ${CFLAGS}/" \
		-e "s/-fno-rtti -O2 -Wall/-fno-rtti ${CXXFLAGS}/" \
		-e "s/-lstdc++fs/${LDFLAGS}/" \
		-e "s/-static-libgcc//" \
		-e "s/-Wl,-Bstatic//" \
		3rd/luamake/compile/ninja/linux.ninja || die

	prefixify_ro "${FILESDIR}/wrapper.sh"
}

src_compile() {
	eninja -C 3rd/luamake -f compile/ninja/linux.ninja "$(usex test "test" "luamake")"
	use test && eninja -C 3rd/luamake -f compile/ninja/linux.ninja luamake
	./3rd/luamake/luamake init || die

	sed -i -e "s/^cc =.*./cc = $(tc-getCC)/" \
		-e "s/^ar =.*./ar = $(tc-getAR)/" \
		-e "s/-std=c11 -O2 -Wall/-std=c11 ${CFLAGS}/" \
		-e "s/-std=c++17 -O2 -Wall/-std=c++17 ${CXXFLAGS}/" \
		-e "s/-lstdc++fs/${LDFLAGS}/" \
		-e "s/-static-libgcc//" \
		-e "s/-Wl,-Bstatic//" \
		build/build.ninja || die

	use test && eninja -f build/build.ninja || eninja -f build/build.ninja all
	rm -rf meta/198256b1
}

src_install() {
	if [[ $(get_libdir) != lib ]]; then
		sed -i "s/lib/$(get_libdir)/" "${T}/wrapper.sh" || die
	fi

	newbin "${T}/wrapper.sh" ${PN}

	into /usr/$(get_libdir)/${PN}
	dobin bin/${PN}

	insinto /usr/$(get_libdir)/${PN}/bin
	doins bin/main.lua

	insinto /usr/$(get_libdir)/${PN}
	doins -r debugger.lua main.lua locale meta script

	einstalldocs
}
