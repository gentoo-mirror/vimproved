# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Synchronized lyrics in your terminal"
HOMEPAGE="https://github.com/raitonoberu/sptlrx"
SRC_URI="
	https://github.com/raitonoberu/sptlrx/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://distfiles.vimproved.dev/${P}-vendor.tar.xz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build
}

src_test() {
	einfo "Running basic sanity-check"
	./sptlrx help || die "sanity-check failed"
}

src_install() {
	dobin sptlrx
	default
}
