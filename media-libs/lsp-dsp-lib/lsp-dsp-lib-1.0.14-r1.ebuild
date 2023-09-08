# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="DSP library for signal processing"
HOMEPAGE="https://github.com/lsp-plugins/lsp-dsp-lib"
SRC_URI="https://github.com/lsp-plugins/${PN}/releases/download/${PV}/${PN}-src-${PV}.tar.gz -> ${P}.tar.gz"

IUSE="static-libs"
LICENSE="LGPL-3+ GPL-3"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/${PN}"

PATCHES=(
	"${FILESDIR}/${P}-c-api-fix-backport.patch"
)

src_configure() {
	emake config
}

src_install() {
	emake DESTDIR="${ED}" INCDIR="/usr/include" LIBDIR="/usr/$(get_libdir)" install
	if ! use static-libs; then
		rm "${ED}/usr/$(get_libdir)/lib${PN}"{,-${PV}}.a || die
	fi
}
