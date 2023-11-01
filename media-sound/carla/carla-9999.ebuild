# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Audio plugin host"
HOMEPAGE="https://kx.studio/carla"
EGIT_REPO_URI="https://github.com/falkTX/Carla.git"

LICENSE="GPL-2 LGPL-3"
SLOT="0"
IUSE="X alsa +fluidsynth +jsfx +opengl pulseaudio +qt5 sdl +sndfile"

RDEPEND="
	sys-apps/file
	X? (
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXrandr
	)
	alsa? ( media-libs/alsa-lib )
	fluidsynth? ( >=media-sound/fluidsynth-1.1.7 )
	opengl? ( media-libs/libglvnd )
	pulseaudio? ( media-libs/libpulse )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		opengl? ( dev-qt/qtgui:5[egl] )
	)
	sdl? ( media-libs/libsdl2 )
	sndfile? ( media-libs/libsndfile )
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-apps/which
"

src_configure() {
	emakeargs=(
		HAVE_ALSA=$(usex alsa true false)
		HAVE_DGL=$(usex opengl true false)
		HAVE_FLUIDSYNTH=$(usex fluidsynth true false)
		HAVE_LIBMAGIC=true
		HAVE_LIBMAGICPKG=true
		HAVE_PULSEAUDIO=$(usex pulseaudio true false)
		HAVE_QT5=$(usex qt5 true false)
		HAVE_QT5PKG=$(use qt5 && use opengl && echo true || echo false)
		HAVE_SDL2=$(usex sdl true false)
		HAVE_SNDFILE=$(usex sndfile true false)
		HAVE_X11=$(usex X true false)
		HAVE_XCURSOR=$(usex X true false)
		HAVE_XEXT=$(usex X true false)
		HAVE_XRANDR=$(usex X true false)
		HAVE_YSFX=$(usex jsfx true false)
	)

	# Requires ffmpeg <=2.8.15
	emakeargs+=( HAVE_FFMPEG=false )

	# pyliblo is no longer packaged in ::gentoo
	emakeargs+=( HAVE_LIBLO=false )

	# Qt4 is no longer packaged in ::gentoo
	emakeargs+=( HAVE_QT4=false )

	# libinstpatch is not yet packaged
	emakeargs+=( HAVE_FLUIDSYNTH_INSTPATCH=false )

	emake "${emakeargs[@]}" features
}

src_compile() {
	emake "${emakeargs[@]}"
}

src_install() {
	emake "${emakeargs[@]}" install
}
