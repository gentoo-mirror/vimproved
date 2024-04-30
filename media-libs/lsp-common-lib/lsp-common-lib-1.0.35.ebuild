# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Common library for basic language definitions used by LSP Project"
HOMEPAGE="https://lsp-plug.in/"
SRC_URI="https://github.com/lsp-plugins/${PN}/releases/download/${PV}/${PN}-src-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3 LGPL-3"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="static-libs test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( media-libs/lsp-test-fw )"

pkg_setup() {
	append-ldflags "-Wl,-soname,lib${P}.so"

	export emakeargs=(
		CFLAGS_EXT="${CFLAGS}"
		CXXFLAGS_EXT="${CXXFLAGS}"
		EXE_FLAGS_EXT="${LDFLAGS}"
		INCDIR="/usr/include"
		LDFLAGS_EXT="$(raw-ldflags)"
		LIBDIR="/usr/$(get_libdir)"
		LSP_TEST_FW_LDFLAGS="-llsp-test-fw"
		LSP_TEST_FW_TYPE="opt"
		SO_FLAGS_EXT="${LDFLAGS}"
		TEST=$(usex test 1 0)
		VERBOSE=1
	)
}

src_prepare() {
	# Remove vendored dependencies
	rm -rf "${S}/modules" || die
	default
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
