# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake xdg

DESCRIPTION="A free software percussion synthesizer for GNU/Linux"
HOMEPAGE="https://gitlab.com/geonkick/geonkick"
SRC_URI="https://gitlab.com/geonkick/geonkick/-/archive/v${PV}/geonkick-v${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+lv2 +standalone vst"
S="${WORKDIR}/geonkick-v${PV}"

DEPEND="
	dev-libs/rapidjson
	media-libs/libsndfile
	media-libs/lv2
	standalone? ( virtual/jack )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DGKICK_STANDALONE=$(usex standalone)
		-DGKICK_VST3=$(usex vst)
		-DGKICK_PLUGIN_LV2=$(usex lv2)
	)

	cmake_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
}
