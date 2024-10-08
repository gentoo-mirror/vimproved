# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit python-single-r1 xdg

DESCRIPTION="Audio plugin host"
HOMEPAGE="https://kx.studio/Applications:Carla"
CARLA_COMMIT="2f7c9394134ad8479a7c9f236123ff365fa68e99"
SRC_URI="https://github.com/falkTX/${PN^}/archive/${CARLA_COMMIT}.tar.gz -> ${PN}-${CARLA_COMMIT}.tar.gz"
S="${WORKDIR}/${PN^}-${CARLA_COMMIT}"

LICENSE="GPL-2 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa debug +fluidsynth +gui +osc pulseaudio sdl +sndfile"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	sys-apps/file
	virtual/jack
	alsa? ( media-libs/alsa-lib )
	elibc_musl? ( sys-libs/fts-standalone )
	gui? (
		dev-qt/qtbase:6[gui,widgets]
		media-libs/libglvnd[X]
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXrandr
		$(python_gen_cond_dep 'dev-python/PyQt6[gui,svg,widgets,${PYTHON_USEDEP}]')
	)
	fluidsynth? ( media-sound/fluidsynth:= )
	pulseaudio? ( media-libs/libpulse )
	sdl? ( media-libs/libsdl2 )
	sndfile? ( media-libs/libsndfile )
	${PYTHON_DEPS}
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-2.6.0_pre20231023-Add-logic-to-autodetect-compiler-and-fix-build-with-clang-on-linux.patch"
	"${FILESDIR}/${PN}-2.6.0_pre20231023-Add-logic-to-automatically-link-against-fts-standalone.patch"
)

src_compile() {
	emake \
		BASE_OPTS= \
		DEBUG="$(usex debug true false)" \
		HAVE_ALSA="$(usex alsa true false)" \
		HAVE_FFMPEG=false \
		HAVE_FLUIDSYNTH="$(usex fluidsynth true false)" \
		HAVE_FRONTEND="$(usex gui true false)" \
		HAVE_HYLIA=true \
		HAVE_LIBLO=false \
		HAVE_LIBMAGIC=true \
		HAVE_PULSEAUDIO="$(usex pulseaudio true false)" \
		HAVE_QT4=false \
		HAVE_QT5=false \
		HAVE_SDL="$(usex sdl true false)" \
		HAVE_SDL2="$(usex sdl true false)" \
		HAVE_SNDFILE="$(usex sndfile true false)" \
		HAVE_X11="$(usex gui true false)" \
		SKIP_STRIPPING=true \
		VERBOSE=1
}

src_install() {
	emake DESTDIR="${ED}" LIBDIR="/usr/$(get_libdir)" PREFIX="/usr" install
	mv "${ED}/usr/share/appdata" "${ED}/usr/share/metainfo" || die

	python_fix_shebang "${ED}"

	newbin - carla <<-EOF
		#!/bin/sh
		INSTALL_PREFIX="${EPREFIX}/usr"
		export PATH="\${INSTALL_PREFIX}/lib/carla:\${PATH}"
		exec ${EPYTHON} "\${INSTALL_PREFIX}/share/carla/carla" \\
			--with-appname="\${0}" \\
			--with-libprefix="\${INSTALL_PREFIX}" \\
			"\${@}"
	EOF
}
