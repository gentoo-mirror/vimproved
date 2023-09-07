# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="C library for reading and writing YAML."
HOMEPAGE="https://github.com/tlsa/libcyaml/"
SRC_URI="https://github.com/tlsa/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug static-libs"

src_compile() {
	emake VARIANT=$(usex debug debug release)
}

src_install() {
	emake DESTDIR="${ED}" PREFIX="/usr" VARIANT=$(usex debug debug release) install

	if ! use static-libs; then
		rm "${ED}/usr/lib/libcyaml.a" || die
	fi
}
