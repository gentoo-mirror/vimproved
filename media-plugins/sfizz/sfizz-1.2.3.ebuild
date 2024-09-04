# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="SFZ parser and synth c++ library, providing a JACK standalone client"
HOMEPAGE="https://sfz.tools/sfizz/"
SRC_URI="https://github.com/sfztools/sfizz-ui/releases/download/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	dev-cpp/abseil-cpp:=
	dev-libs/glib:2
	dev-libs/pugixml
	gnome-extra/zenity
	media-libs/fontconfig
	media-sound/wavpack
	sci-libs/kissfft
	virtual/jack
	x11-libs/cairo
	x11-libs/libxcb:=
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-libs/xcb-util
	x11-libs/xcb-util-cursor
"
DEPEND="
	${RDEPEND}
	dev-cpp/gulrak-filesystem
	dev-libs/cxxopts
	media-libs/lv2
"

PATCHES=(
	"${FILESDIR}/${P}-missing-include.patch"
)

src_configure() {
	local kissfft_variant=float
	local kissfft_openmp=
	if has_version "sci-libs/kissfft[cpu_flags_x86_sse]"; then
		kissfft_variant=simd
	fi
	if has_version "sci-libs/kissfft[openmp]"; then
		kissfft_openmp=-openmp
	fi
	local mycmakeargs=(
		-DENABLE_LTO=OFF
		-DKISSFFT_FFTR_LIBRARY="/usr/$(get_libdir)/libkissfft-${kissfft_variant}${kissfft_openmp}.so"
		-DKISSFFT_FFT_LIBRARY="/usr/$(get_libdir)/libkissfft-${kissfft_variant}${kissfft_openmp}.so"
		-DSFIZZ_USE_SYSTEM_ABSEIL=ON
		-DSFIZZ_USE_SYSTEM_CATCH=ON
		-DSFIZZ_USE_SYSTEM_CXXOPTS=ON
		-DSFIZZ_USE_SYSTEM_GHC_FS=ON
		-DSFIZZ_USE_SYSTEM_LV2=ON
		-DSFIZZ_USE_SYSTEM_SIMDE=ON
		-DSFIZZ_USE_SYSTEM_KISS_FFT=ON
		-DSFIZZ_USE_SYSTEM_PUGIXML=ON
	)

	cmake_src_configure
}
