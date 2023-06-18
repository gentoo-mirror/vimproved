# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=( lua{5-{1,3,4},jit} )

inherit ninja-utils toolchain-funcs lua-single prefix

DESCRIPTION="Lua language server"
HOMEPAGE="https://github.com/LuaLS/lua-language-server"
SRC_URI="https://github.com/LuaLS/lua-language-server/releases/download/${PV}/${P}-submodules.zip -> ${P}.zip"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
REQUIRE_USE="${LUA_REQUIRED_USE}"

DEPEND="${LUA_DEPS}"
RDEPEND="${DEPEND}"
BDEPEND="
	app-arch/unzip
	dev-util/ninja
"
RESTRICT="!test? ( test )"
PATCHES=( "${FILESDIR}/linux.ninja.patch" "${FILESDIR}/build.ninja.patch" )

src_prepare() {
	# all this sed hackery is needed because upstream appears to have a stick up their ass
	# Remove hardcoded gcc references
	sed -i "/lm.cxx/a lm.cc = '$(tc-getCC)'" \
		make.lua || die
	sed -i "s/CC = gcc/ CC = ${tc-getCC}/" \
		3rd/lpeglabel/makefile || die
	# Shipped file doesn't respect CFLAGS/CXXFLAGS/LDFLAGS
	eapply "${FILESDIR}/linux.ninja.patch"
	eapply_user
	sed -i -e "s/^cc = REPLACE_ME/cc = $(tc-getCC)/" \
		-e "s/CFLAGS/${CFLAGS}/" \
		-e "s/CXXFLAGS/${CXXFLAGS}/" \
		-e "s/LDFLAGS/${LDFLAGS}/" \
		3rd/luamake/compile/ninja/linux.ninja || die

	if [[ "$(tc-get-cxx-stdlib)" = "libc++" ]] ; then
		sed -i -e "s/-lstdc++fs//g" \
			-e "s/-lstdc++/-lc++/g" \
			-e "s/-Wl,-Bstatic//g" \
			3rd/luamake/compile/ninja/linux.ninja || die
	fi

	prefixify_ro "${FILESDIR}/wrapper.sh"
}

src_compile() {
	eninja -C 3rd/luamake -f compile/ninja/linux.ninja "$(usex test "test" "luamake")"
	use test && eninja -C 3rd/luamake -f compile/ninja/linux.ninja luamake
	./3rd/luamake/luamake init || die

	# Generated file doesn't respect CFLAGS/CXXFLAGS/LDFLAGS
	sed -i -e "s/^cc =.*./cc = REPLACE_ME/" \
		-e "s/^luamake =.*./luamake = LUAMAKE_PATH/" \
		build/build.ninja || die

	eapply "${FILESDIR}/build.ninja.patch"
	sed -i -e "s/REPLACE_ME/$(tc-getCC)/" \
		-e "s|LUAMAKE_PATH|${S}/3rd/luamake/luamake|" \
		-e "s/CFLAGS/${CFLAGS}/" \
		-e "s/CXXFLAGS/${CXXFLAGS}/" \
		-e "s/LDFLAGS/${LDFLAGS}/" \
		-e "7d" \
		build/build.ninja || die

	if [[ "$(tc-get-cxx-stdlib)" = "libc++" ]] ; then
		sed -i -e "s/-lstdc++fs//g" \
			-e "s/-lstdc++/-lc++/g" \
			-e "s/-Wl,-Bstatic//g" \
			build/build.ninja || die
	fi

	use test && eninja -f build/build.ninja || eninja -f build/build.ninja all
}

src_install() {
	newbin "${T}/wrapper.sh" ${PN}

	into /opt/${PN}
	dobin bin/${PN}

	insinto /opt/${PN}/bin
	doins bin/main.lua

	insinto /opt/${PN}
	doins -r debugger.lua main.lua locale meta script

	einstalldocs
}