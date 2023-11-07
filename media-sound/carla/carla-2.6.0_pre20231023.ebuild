# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )
inherit python-single-r1 xdg

FALKTX_CARLA_COMMIT="41f07e119252b8b14627bec8345cb7304485a815"

DESCRIPTION="Audio plugin host"
HOMEPAGE="https://kx.studio/Applications:Carla"
SRC_URI="https://github.com/falkTX/Carla/archive/${FALKTX_CARLA_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+X alsa debug +fluidsynth +gui +opengl +osc pulseaudio sdl +sndfile"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
S="${WORKDIR}/Carla-${FALKTX_CARLA_COMMIT}"

RDEPEND="
	sys-apps/file
	virtual/jack
	X? (
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXrandr
	)
	alsa? ( media-libs/alsa-lib )
	elibc_musl? ( sys-libs/fts-standalone )
	gui? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		opengl? ( dev-qt/qtgui:5[egl] )
		$(python_gen_cond_dep 'dev-python/PyQt5[gui,svg,widgets,${PYTHON_USEDEP}]')
	)
	fluidsynth? ( media-sound/fluidsynth:= )
	opengl? ( media-libs/libglvnd )
	osc? (
		media-libs/liblo
		$(python_gen_cond_dep 'dev-python/pyliblo3[${PYTHON_USEDEP}]')
	)
	pulseaudio? ( media-libs/libpulse )
	sdl? ( media-libs/libsdl2 )
	sndfile? ( media-libs/libsndfile )
	${PYTHON_DEPS}
"
DEPEND="${RDEPEND}"
BDEPEND="dev-python/PyQt5"

PATCHES=(
	"${FILESDIR}/carla-2.6.0_pre20231023-Add-logic-to-autodetect-compiler-and-fix-build-with-clang-on-linux.patch"
	"${FILESDIR}/carla-2.6.0_pre20231023-Add-logic-to-automatically-link-against-fts-standalone.patch"
)

pkg_setup() {
	export emakeargs=(
		DEBUG=$(usex debug true false)
		HAVE_ALSA=$(usex alsa true false)
		HAVE_DBUS=false
		HAVE_DGL=$(usex opengl true false)
		HAVE_FFMPEG=false
		HAVE_FLUIDSYNTH=$(usex fluidsynth true false)
		HAVE_FRONTEND=$(usex gui true false)
		HAVE_FTS_STANDALONE=$(usex elibc_musl true false)
		HAVE_LIBLO=$(usex osc true false)
		HAVE_PULSEAUDIO=$(usex pulseaudio true false)
		HAVE_PYQT=$(usex gui true false)
		HAVE_QT4=false
		HAVE_QT5=$(usex gui true false)
		HAVE_SDL1=false
		HAVE_SDL2=true
		HAVE_SNDFILE=$(usex sndfile true false)
		HAVE_X11=$(usex X true false)
		HAVE_XCURSOR=$(usex X true false)
		HAVE_XEXT=$(usex X true false)
		HAVE_XRANDR=$(usex X true false)
		HAVE_YSFX=true
		JACKBRIDGE_DIRECT=true
		LIBDIR="/usr/$(get_libdir)"
		PREFIX="/usr"
		SKIP_STRIPPING=true
		USING_RTAUDIO=true
	)
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
}
