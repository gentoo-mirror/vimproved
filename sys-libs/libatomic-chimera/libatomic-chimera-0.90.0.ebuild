# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An implementation of libatomic"
HOMEPAGE="https://github.com/chimera-linux/libatomic-chimera"
SRC_URI="https://github.com/chimera-linux/libatomic-chimera/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

DEPEND="!sys-devel/gcc"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${ED}" PREFIX="/usr" install
}
