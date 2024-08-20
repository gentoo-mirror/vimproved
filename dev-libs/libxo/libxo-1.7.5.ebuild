# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Generate text, XML, JSON, and HTML output using a common set of function calls."
HOMEPAGE="https://github.com/Juniper/libxo"
SRC_URI="https://github.com/Juniper/libxo/releases/download/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

PATCHES=(
	"${FILESDIR}/libxo-1.7.5-slibtool.patch"
)

src_test() {
	emake test
}
