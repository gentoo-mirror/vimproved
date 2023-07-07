# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit autotools

DESCRIPTION="Generate text, XML, JSON, and HTML output using a common set of function calls."
HOMEPAGE="https://juniper.github.io/libxo/libxo-manual.html"
SRC_URI="https://github.com/Juniper/libxo/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}/${P}-portability.patch"
)

src_prepare() {
	eautoreconf
	default
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
