# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

FALKTX_CARLA_COMMIT="41f07e119252b8b14627bec8345cb7304485a815"

DESCRIPTION="Audio plugin host"
HOMEPAGE="https://kx.studio/Applications:Carla"
SRC_URI="https://github.com/falkTX/Carla/archive/${FALKTX_CARLA_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"
S="${WORKDIR}/Carla-${FALKTX_CARLA_COMMIT}"

RDEPEND="
	dev-python/PyQt5[gui,svg,widgets]
	dev-qt/qtcore:5
	dev-qt/qtgui:5[egl]
	dev-qt/qtwidgets:5
	media-libs/alsa-lib
	media-libs/libglvnd
	media-sound/fluidsynth
	virtual/jack
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXrandr
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
		HAVE_ALSA=true
		HAVE_DBUS=false
		HAVE_DGL=true
		HAVE_FFMPEG=false
		HAVE_FLUIDSYNTH=true
		HAVE_FRONTEND=true
		HAVE_FTS_STANDALONE=$(usex elibc_musl true false)
		HAVE_LIBLO=true
		HAVE_PULSEAUDIO=true
		HAVE_PYQT=true
		HAVE_QT4=false
		HAVE_QT5=true
		HAVE_X11=true
		HAVE_XCURSOR=true
		HAVE_XEXT=true
		HAVE_XRANDR=true
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
