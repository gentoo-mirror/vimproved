# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake xdg

DESCRIPTION="A free software percussion synthesizer for GNU/Linux"
HOMEPAGE="https://geonkick.org"
SRC_URI="https://gitlab.com/${PN}-synthesizer/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+lv2 +standalone"
S="${WORKDIR}/${PN}-v${PV}"

DEPEND="
	dev-libs/rapidjson
	media-libs/libsndfile
	media-libs/lv2
	standalone? ( virtual/jack )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-2.10.1-remove-stdc++fs.patch"
)

src_configure() {
	local mycmakeargs=(
		-DGKICK_STANDALONE=$(usex standalone)
		-DGKICK_PLUGIN_LV2=$(usex lv2)
	)

	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
}
