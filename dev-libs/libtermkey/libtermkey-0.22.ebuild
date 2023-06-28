# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit flag-o-matic meson

DESCRIPTION="Library for easy processing of keyboard entry from terminal-based programs"
HOMEPAGE="http://www.leonerd.org.uk/code/libtermkey/"
SRC_URI="http://www.leonerd.org.uk/code/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~ppc64 ~riscv x86 ~x64-macos"
IUSE="demos static-libs"

RDEPEND="dev-libs/unibilium:="
DEPEND="${RDEPEND}
	sys-devel/libtool
	virtual/pkgconfig
	demos? ( dev-libs/glib:2 )"

src_prepare() {
	cp "${FILESDIR}/meson.build" "${S}/meson.build"
	default

	if ! use demos; then
		sed -e '/^all:/s:$(DEMOS)::' -i Makefile || die
	fi
}

src_compile() {
	append-flags -fPIC
	meson_src_compile
}
