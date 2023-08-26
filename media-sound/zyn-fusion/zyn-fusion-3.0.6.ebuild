# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
USE_RUBY="ruby27 ruby30 ruby31 ruby32"
inherit ruby-single toolchain-funcs

DESCRIPTION="A new interface for ZynAddSubFX"
HOMEPAGE="https://zynaddsubfx.sourceforge.io/"
SRC_URI="mirror://sourceforge/zynaddsubfx/zyn-fusion-ui-src-${PV}.tar.bz2"
S="${WORKDIR}/zyn-fusion-ui-src-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/libuv
	x11-libs/libX11
	x11-libs/libxcb
	${RUBY_DEPS}
"
RDEPEND="${DEPEND}"

src_prepare() {
	# Unbundle libuv: makefile and rake file
	sed -i -e "s%./deps/\$(UV_DIR)/.libs/libuv.a%`pkg-config --libs libuv`%" \
		-e 's%-I ../../deps/\$(UV_DIR)/include%-I /usr/include/uv/%' Makefile
	sed -i -e "/deps\/libuv.a/s/<< .*/<< \"`pkg-config --libs libuv`\"/" \
		-e 's%../deps/libuv-v1.9.1/include/%usr/include/uv/%' build_config.rb
	eapply_user
	LD="$(tc-getCC)"
}

src_compile() {
	default_src_compile
	emake pack
}

src_install() {
	cd package

	exeinto /opt/${PN}
	doexe zest
	dodir /usr/bin/
	dosym ../../opt/${PN}/zest /usr/bin/${PN}

	insinto /opt/${PN}
	doins -r font qml schema libzest.so
}
