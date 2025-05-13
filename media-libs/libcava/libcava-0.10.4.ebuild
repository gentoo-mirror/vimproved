# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Console-based Audio Visualizer for Alsa"
HOMEPAGE="https://github.com/LukashonakV/cava/"
SRC_URI="https://github.com/LukashonakV/cava/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cava-${PV}"

LICENSE="MIT Unlicense"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa jack pipewire portaudio pulseaudio sndio"
RESTRICT="test"

RDEPEND="
	>=dev-libs/iniparser-4.1-r2:=
	sci-libs/fftw:3.0=
	alsa? ( media-libs/alsa-lib )
	jack? ( virtual/jack )
	pipewire? ( media-video/pipewire:= )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-libs/libpulse )
	sndio? ( media-sound/sndio:= )
"
DEPEND="${RDEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_feature alsa input_alsa)
		$(meson_feature jack input_jack)
		$(meson_feature pipewire input_pipewire)
		$(meson_feature portaudio input_portaudio)
		$(meson_feature pulseaudio input_pulse)
		$(meson_feature sndio input_sndio)

		-Doutput_ncurses=disabled
		-Doutput_sdl=disabled
		-Doutput_sdl_glsl=disabled
	)

	meson_src_configure
}

src_compile() {
	mkdir -p "${BUILD_DIR}/src/output/" || die
	cp -r "${S}/src/output/shaders" "${BUILD_DIR}/src/output/" || die
	cp -r "${S}/example_files" "${BUILD_DIR}"

	meson_src_compile
}
