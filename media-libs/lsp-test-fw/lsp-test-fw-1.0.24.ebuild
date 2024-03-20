# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Simple test framework for writing and executing tests used by LSP Project"
HOMEPAGE="https://lsp-plug.in/"
SRC_URI="https://github.com/lsp-plugins/${PN}/releases/download/${PV}/${PN}-src-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs test"
RESTRICT="!test? ( test )"

pkg_setup() {
	append-ldflags "-Wl,-soname,lib${P}.so"

	export emakeargs=(
		CFLAGS_EXT="${CFLAGS}"
		CXXFLAGS_EXT="${CXXFLAGS}"
		EXE_FLAGS_EXT="${LDFLAGS}"
		INCDIR="/usr/include"
		LDFLAGS_EXT="$(raw-ldflags)"
		LIBDIR="/usr/$(get_libdir)"
		SO_FLAGS_EXT="${LDFLAGS}"
		TEST=$(usex test 1 0)
		VERBOSE=1
	)
}

src_configure() {
	emake "${emakeargs[@]}" config
}

src_compile() {
	emake "${emakeargs[@]}"
}

src_test() {
	"${S}/.build/target/${PN}/${PN}-test" utest -v || die
}

src_install() {
	emake "${emakeargs[@]}" DESTDIR="${ED}" install

	if ! use static-libs; then
		find "${ED}" -name '*.a' -delete || die
	fi
}
