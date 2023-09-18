# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
inherit flag-o-matic git-r3 python-single-r1 toolchain-funcs xdg-utils

DESCRIPTION="Fully-featured audio plugin host, supports many audio drivers and plugin formats"
HOMEPAGE="http://kxstudio.linuxaudio.org/Applications:Carla"
EGIT_REPO_URI="https://github.com/falkTX/Carla.git"
EGIT_SUBMODULES=()

KEYWORDS=""
LICENSE="GPL-2+ LGPL-3"
SLOT="0"
IUSE="+X alsa fluidsynth +jsfx +magic +opengl +osc pulseaudio +qt5 rdf sdl sndfile"
REQUIRED_USE="
	opengl? ( X )
	${PYTHON_REQUIRED_USE}
"

DEPEND="
	X? (
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXrandr
	)
	alsa? ( media-libs/alsa-lib )
	magic? ( sys-apps/file )
	opengl? (
		media-libs/libglvnd
		qt5? (
			dev-qt/qtgui:5[egl]
		)
	)
	osc? ( media-libs/liblo )
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	)
	sdl? ( media-libs/libsdl2[sound] )
	sndfile? (
		media-libs/libsndfile
	)
"
RDEPEND="
	osc? ( dev-python/pyliblo3 )
	rdf? ( dev-python/rdflib )
	qt5? ( dev-python/PyQt5[gui,svg,widgets] )
	${DEPEND}
	${PYTHON_DEPS}
"

PATCHES=(
	"${FILESDIR}/${PN}-9999-clang.patch"
	"${FILESDIR}/${PN}-9999-musl-1.2.4.patch"
)

src_prepare() {
	sed -i -e "s|exec \$PYTHON|exec ${PYTHON}|" \
		data/carla \
		data/carla-control \
		data/carla-database \
		data/carla-jack-multi \
		data/carla-jack-single \
		data/carla-patchbay \
		data/carla-rack \
		data/carla-settings || die "sed failed"
	default
}

src_compile() {
	use elibc_musl && append-ldflags "-lfts"
	myemakeargs=(
		CLANG=$(tc-is-clang && echo true)
		HAVE_ALSA=$(usex alsa true false)
		HAVE_DBUS=false
		HAVE_DGL=$(usex opengl true false)
		HAVE_FFMPEG=false
		HAVE_FLUIDSYNTH=$(usex fluidsynth true false)
		HAVE_FRONTEND=$(usex qt5 true false)
		HAVE_JACK=true
		HAVE_JACKLIB=false
		HAVE_LIBLO=$(usex osc true false)
		HAVE_LIBMAGIC=$(usex magic true false)
		HAVE_LIBMAGICPKG=$(usex magic true false)
		HAVE_PULSEAUDIO=$(usex pulseaudio true false)
		HAVE_PYQT=$(usex qt5 true false)
		HAVE_QT4=false
		HAVE_QT5=$(usex qt5 true false)
		HAVE_QT5PKG=$(use opengl && use qt5 && echo true)
		HAVE_SDL1=false
		HAVE_SDL2=$(usex sdl true false)
		HAVE_SNDFILE=$(usex sndfile true false)
		HAVE_YSFX=$(usex jsfx true false)
		HAVE_YSFXGUI=false
		HAVE_X11=$(usex X true false)
		HAVE_XCURSOR=$(usex X true false)
		HAVE_XEXT=$(usex X true false)
		HAVE_XRANDR=$(usex X true false)
		JACKBRIDGE_DIRECT=false
		LIBDIR="/usr/$(get_libdir)"
		SKIP_STRIPPING=true
	)

	# Print which options are enabled/disabled
	emake features PREFIX="/usr" "${myemakeargs[@]}"

	emake PREFIX="/usr" "${myemakeargs[@]}"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" "${myemakeargs[@]}" install
	if ! use osc; then
		find "${D}/usr" -iname "carla-control*" | xargs rm
	fi
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}
