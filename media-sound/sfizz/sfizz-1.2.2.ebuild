# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="SFZ parser and synth c++ library"
HOMEPAGE="https://sfz.tools/sfizz/"
SRC_URI="https://github.com/sfztools/sfizz/releases/download/${PV}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="jack sndfile"

DEPEND="
	dev-cpp/abseil-cpp
	gnome-extra/zenity
	media-libs/fontconfig
	media-libs/freetype
	media-sound/wavpack
	x11-libs/cairo
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-libs/xcb-util
	x11-libs/xcb-util-cursor
	x11-libs/xcb-util-keysyms
"
RDEPEND="${DEPEND}"
BDEPEND="dev-cpp/catch"

src_configure() {
	local mycmakeargs=(
		-DLV2PLUGIN_INSTALL_DIR="/usr/$(get_libdir)/lv2"
		-DSFIZZ_JACK=$(usex jack)
		-DSFIZZ_USE_SNDFILE=$(usex sndfile)
		-DSFIZZ_USE_SYSTEM_ABSEIL=ON
		-DSFIZZ_USE_SYSTEM_CATCH=ON
		-DVSTPLUGIN_INSTALL_DIR="/usr/$(get_libdir)/vst3"
	)
	cmake_src_configure
}
