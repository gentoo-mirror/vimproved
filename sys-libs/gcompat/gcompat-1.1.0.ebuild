# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The GNU C Library Compatibility Layer for Adélie Linux"
HOMEPAGE="https://git.adelielinux.org/adelie/gcompat/"
SRC_URI="https://git.adelielinux.org/adelie/gcompat/-/archive/${PV}/${P}.tar.bz2"

LICENSE="UoI-NCSA"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="sys-libs/obstack-standalone"
RDEPEND="${DEPEND}"

src_compile() {
	emake WITH_OBSTACK="obstack-standalone" LINKER_PATH="/$(get_libdir)/ld-musl-x86_64.so.1"
}

src_install() {
	emake DESTDIR="${ED}" LOADER_PATH="/lib/ld-linux-x86-64.so.2" install
	dosym ../lib/ld-linux-x86-64.so.2 /lib64/ld-linux-x86-64.so.2
}
