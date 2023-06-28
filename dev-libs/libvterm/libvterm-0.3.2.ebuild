# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit meson

DESCRIPTION="An abstract library implementation of a VT220/xterm/ECMA-48 terminal emulator"
HOMEPAGE="https://www.leonerd.org.uk/code/libvterm/"
SRC_URI="https://www.leonerd.org.uk/code/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~riscv ~x86 ~x64-macos"

BDEPEND="
	dev-lang/perl
	sys-devel/libtool
"

src_prepare() {
	cp "${FILESDIR}/meson.build" "${S}/meson.build"
	default
}
