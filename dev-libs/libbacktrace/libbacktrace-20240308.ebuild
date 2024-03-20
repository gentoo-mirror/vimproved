# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Library to produce symbolic backtraces"
HOMEPAGE="https://github.com/ianlancetaylor/libbacktrace"
LIBBACKTRACE_COMMIT="9ae4f4ae4481b1e69d38ed810980d33103544613"
SRC_URI="https://github.com/ianlancetaylor/${PN}/archive/${LIBBACKTRACE_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${LIBBACKTRACE_COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

src_configure() {
	# Breaks due to grepping an object file
	filter-lto

	econf \
		--disable-werror \
		--enable-shared
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
