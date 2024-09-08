# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit python-single-r1 xdg

DESCRIPTION="Audio plugin host"
HOMEPAGE="https://kx.studio/Applications:Carla"
CARLA_COMMIT="74262a5dace5338444a6599e65d97c3b98968c96"
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

pkg_setup() {
	emakeargs=(
		DEBUG=$(usex debug true false)
		HAVE_ALSA=$(usex alsa true false)
		HAVE_DBUS=false
		HAVE_DGL=$(usex gui true false)
		HAVE_FFMPEG=false
		HAVE_FLUIDSYNTH=$(usex fluidsynth true false)
		HAVE_FRONTEND=$(usex gui true false)
		HAVE_FTS_STANDALONE=$(usex elibc_musl true false)
		HAVE_LIBLO=false
		HAVE_PULSEAUDIO=$(usex pulseaudio true false)
		HAVE_PYQT=$(usex gui true false)
		HAVE_QT4=false
		HAVE_QT5=false
		HAVE_QT5PKG=false
		HAVE_QT6=$(usex gui true false)
		HAVE_SDL1=false
		HAVE_SDL2=$(usex sdl true false)
		HAVE_SNDFILE=$(usex sndfile true false)
		HAVE_X11=$(usex gui true false)
		HAVE_XCURSOR=$(usex gui true false)
		HAVE_XEXT=$(usex gui true false)
		HAVE_XRANDR=$(usex gui true false)
		HAVE_YSFX=true
		JACKBRIDGE_DIRECT=true
		LIBDIR="/usr/$(get_libdir)"
		PREFIX="/usr"
		PYUIC="pyuic6"
		SKIP_STRIPPING=true
		USING_RTAUDIO=true
	)

	python-single-r1_pkg_setup
}

src_configure() {
	emake "${emakeargs[@]}" features
}

src_compile() {
	emake "${emakeargs[@]}"
}

src_install() {
	emake "${emakeargs[@]}" DESTDIR="${ED}" install
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
