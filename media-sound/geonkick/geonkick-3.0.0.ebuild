# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="A free software percussion synthesizer for GNU/Linux"
HOMEPAGE="https://geonkick.org"
SRC_URI="https://gitlab.com/geonkick-synthesizer/geonkick/-/archive/v${PV}/geonkick-v${PV}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/geonkick-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+lv2 +standalone"
RESTRICT="test"

RDEPEND="
	dev-libs/rapidjson
	media-libs/libsndfile
	media-libs/lv2
	x11-libs/cairo[X]
	standalone? ( virtual/jack )
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/geonkick-3.0.0-remove-link-to-libstdc++fs.patch"
)

src_configure() {
	local mycmakeargs=(
		-DGKICK_PLUGIN_LV2=$(usex lv2)
		-DGKICK_STANDALONE=$(usex standalone)
	)

	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
}