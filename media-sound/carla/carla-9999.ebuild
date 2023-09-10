# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
inherit flag-o-matic git-r3 python-single-r1 toolchain-funcs xdg-utils

DESCRIPTION="Fully-featured audio plugin host, supports many audio drivers and plugin formats"
HOMEPAGE="http://kxstudio.linuxaudio.org/Applications:Carla"
EGIT_REPO_URI="https://github.com/falkTX/Carla.git"
EGIT_SUBMODULES=()

IUSE="+X alsa opengl +osc pulseaudio rdf sf2 +sndfile"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
LICENSE="GPL-2+ LGPL-3"
SLOT="0"

DEPEND="
	dev-python/PyQt5[gui,opengl?,svg,widgets]
	virtual/jack
	X? ( x11-libs/libX11 )
	alsa? ( media-libs/alsa-lib )
	osc? (
		dev-python/pyliblo3
		media-libs/liblo
	)
	pulseaudio? ( media-libs/libpulse )
	rdf? ( dev-python/rdflib )
	sf2? ( media-sound/fluidsynth )
	sndfile? ( media-libs/libsndfile )
"
RDEPEND="
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
		LIBDIR="/usr/$(get_libdir)"
		SKIP_STRIPPING=true
		HAVE_FFMPEG=false
		HAVE_ZYN_DEPS=false
		HAVE_ZYN_UI_DEPS=false
		HAVE_QT4=false
		HAVE_QT5=true
		HAVE_PYQT5=true
		HAVE_ALSA=$(usex alsa true false)
		HAVE_FLUIDSYNTH=$(usex sf2 true false)
		HAVE_LIBLO=$(usex osc true false)
		HAVE_PULSEAUDIO=$(usex pulseaudio true false)
		HAVE_SNDFILE=$(usex sndfile true false)
		HAVE_X11=$(usex X true false)
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
