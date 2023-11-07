# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="DSP library for signal processing"
HOMEPAGE="https://lsp-plug.in/"
SRC_URI="https://github.com/lsp-plugins/lsp-dsp-lib/releases/download/${PV}/lsp-dsp-lib-src-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"
S="${WORKDIR}/lsp-dsp-lib"

RDEPEND="media-libs/lsp-common-lib"
DEPEND="${RDEPEND}"

pkg_setup() {
	append-ldflags "-Wl,-soname,lib${P}.so"

	export emakeargs=(
		CFLAGS_EXT="${CFLAGS}"
		CXXFLAGS_EXT="${CXXFLAGS}"
		EXE_FLAGS_EXT="${LDFLAGS}"
		INCDIR="/usr/include"
		LDFLAGS_EXT="$(raw-ldflags)"
		LIBDIR="/usr/$(get_libdir)"
		LSP_COMMON_LIB_LDFLAGS="-llsp-common-lib"
		LSP_COMMON_LIB_TYPE="opt"
		SO_FLAGS_EXT="${LDFLAGS}"
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

src_install() {
	emake "${emakeargs[@]}" DESTDIR="${ED}" install

	if ! use static-libs; then
		find "${ED}" -name '*.a' -delete || die
	fi
}
