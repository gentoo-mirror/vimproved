# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The GNU C Library Compatibility Layer for Adélie Linux"
HOMEPAGE="https://git.adelielinux.org/adelie/gcompat"
SRC_URI="https://git.adelielinux.org/adelie/gcompat/-/archive/${PV}/${P}.tar.bz2"

LICENSE="UoI-NCSA"
SLOT="0"

RDEPEND="
	sys-libs/libucontext
	sys-libs/obstack-standalone
"
DEPEND="${RDEPEND}"

pkg_setup() {
	emakeargs=(
		LINKER_PATH="/lib/ld-musl-${CHOST%%-*}.so.1"
		WITH_LIBUCONTEXT=1
	)
}

src_compile() {
	emake "${emakeargs[@]}"
}

src_install() {
	# Only install libgcompat, not the elf interpreter stub. The correct path
	# too difficult to figure out, and for some reason having it installed
	# breaks Syncthing.
	dolib.so "${S}/libgcompat.so.0"
	dosym libgcompat.so.0 "/usr/$(get_libdir)/libgcompat.so"
}
