# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Glibc Library Compatibility Layer"
HOMEPAGE="https://git.adelielinux.org/adelie/gcompat"
SRC_URI="https://git.adelielinux.org/adelie/gcompat/-/archive/${PV}/${P}.tar.bz2"

LICENSE="UoI-NCSA"
SLOT="0/0"
KEYWORDS="~amd64"

DEPEND="
	!sys-libs/glibc
	sys-libs/libucontext
	sys-libs/obstack-standalone
"
RDEPEND="${DEPEND}"

src_compile() {
	# TODO: support non-amd64 arches
	emake WITH_LIBUCONTEXT=1 WITH_OBSTACK=1
}

src_install() {
	emake WITH_LIBUCONTEXT=1 \
		WITH_OBSTACK=1 \
		LOADER_PATH=/lib64/ld-linux-x86-64.so.2 \
		LIBGCOMPAT_PATH="/$(get_libdir)/libgcompat.so.0" \
		DESTDIR="${ED}" install
}
