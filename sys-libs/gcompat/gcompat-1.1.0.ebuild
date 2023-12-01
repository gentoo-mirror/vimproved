# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="The GNU C Library Compatibility Layer for Adélie Linux"
HOMEPAGE="https://git.adelielinux.org/adelie/gcompat"
SRC_URI="https://git.adelielinux.org/adelie/gcompat/-/archive/${PV}/${P}.tar.bz2"

LICENSE="UoI-NCSA"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	sys-libs/libucontext
	sys-libs/obstack-standalone
"
DEPEND="${RDEPEND}"

pkg_setup() {
	emakeargs=(
		LINKER_PATH="/lib/ld-musl-x86_64.so.1"
		LOADER_PATH="/lib64/ld-linux-x86-64.so.2"
		DESTDIR="${ED}"
		WITH_LIBUCONTEXT=1
	)
}

src_compile() {
	emake "${emakeargs[@]}"
}

src_install() {
	emake "${emakeargs[@]}" install
}
