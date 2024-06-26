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

DEPEND="dev-libs/libyaml"
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

pkg_setup() {
	emakeargs=(
		LIBDIR="$(get_libdir)"
		PREFIX="/usr"
		VARIANT=$(usex debug debug release)
	)
}

src_compile() {
	emake "${emakeargs[@]}"
}

src_install() {
	emake "${emakeargs[@]}" DESTDIR="${ED}" install
	if ! use static-libs; then
		find "${ED}" -name '*.a' -delete || die
	fi
}
