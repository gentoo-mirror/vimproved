# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit meson

DESCRIPTION="A lightweight C99 portability and data structure library"
HOMEPAGE="https://gitlab.com/drobilla/zix"
SRC_URI="https://gitlab.com/drobilla/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2"

IUSE="doc test"
LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/${PN}-v${PV}"

BDEPEND="doc? ( app-doc/doxygen )"

RESTRICT="!test? ( test )"

src_configure() {
	local emesonargs=(
		$(meson_feature doc docs)
		$(meson_feature doc html)
		$(meson_feature test tests)
		$(meson_feature test tests_cpp)
	)

	meson_src_configure
}
