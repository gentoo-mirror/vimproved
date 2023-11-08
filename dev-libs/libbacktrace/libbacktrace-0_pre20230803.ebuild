# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

MY_PV="9ae4f4ae4481b1e69d38ed810980d33103544613"

DESCRIPTION="Library to produce symbolic backtraces"
HOMEPAGE="https://github.com/ianlancetaylor/libbacktrace"
SRC_URI="https://github.com/ianlancetaylor/libbacktrace/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/${PN}-${MY_PV}"

src_configure() {
	local econfargs=(
		--disable-werror
		--enable-shared
	)

	# Compiles with LTO, but upstream made the mind-bogglingly stupid decision
	# of having a BACKTRACE_SUPPORTED macro that gets defined to 0 when
	# compiled with LTO
	filter-lto

	econf
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete || die
}
