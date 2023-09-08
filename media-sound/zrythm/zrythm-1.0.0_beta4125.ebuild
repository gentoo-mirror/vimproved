# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit gnome2-utils meson xdg

BETA_PV="$(ver_cut 5)"
MY_PV="$(ver_cut 1-3)-beta.${BETA_PV:0:1}.${BETA_PV:1:2}.${BETA_PV:3}"
DESCRIPTION="highly automated and intuitive digital audio workstation"
HOMEPAGE="https://zrythm.org/"
SRC_URI="https://www.zrythm.org/releases/${PN}-${MY_PV}.tar.xz -> ${P}.tar.xz"

IUSE="X alsa graphviz +guile +jack opus +plugins pulseaudio rtaudio rtmidi sdl +simd"
LICENSE="AGPL-3+"
SLOT="0"
S="${WORKDIR}/${PN}-${MY_PV}"

DEPEND="
	app-arch/zstd
	dev-libs/json-glib
	dev-libs/libbacktrace
	dev-libs/libcyaml
	dev-libs/libpcre2
	dev-libs/reproc
	dev-libs/xxhash
	dev-libs/zix
	gui-libs/gtk[X?]
	gui-libs/gtksourceview
	gui-libs/libadwaita
	gui-libs/libpanel
	media-libs/libsndfile
	media-libs/lilv
	media-libs/rubberband
	media-libs/soxr
	media-libs/vamp-plugin-sdk
	>=media-sound/carla-2.6.0
	net-misc/curl
	sci-libs/fftw[threads]
	X? ( x11-libs/libX11 )
	alsa? ( media-libs/alsa-lib )
	graphviz? ( media-gfx/graphviz )
	guile? ( dev-scheme/guile )
	jack? ( virtual/jack )
	opus? ( >=media-libs/libsndfile-1.0.29 )
	plugins? ( dev-libs/boost )
	rtaudio? ( media-libs/rtaudio )
	rtmidi? ( media-libs/rtmidi )
	sdl? ( media-libs/libsdl2 )
	simd? ( media-libs/lsp-dsp-lib )
"
RDEPEND="
	${DEPEND}
	kde-frameworks/breeze-icons
"
BDEPEND="
	dev-lang/sassc
	dev-scheme/guile
	x11-misc/xdg-utils
"

PATCHES=(
	"${FILESDIR}/${PN}-1.0.0_beta4125-musl-execinfo.patch"
)

src_configure() {
	local emesonargs=(
		-Dbuild_plugins_with_static_libs=false
		-Dcompletions=false
		$(meson_feature X x11)
		$(meson_feature alsa)
		$(meson_use plugins bundled_plugins)
		$(meson_feature graphviz)
		$(meson_feature guile)
		$(meson_feature jack)
		$(meson_feature pulseaudio pulse)
		$(meson_feature rtaudio)
		$(meson_feature rtmidi)
		$(meson_feature sdl)
		$(meson_feature simd lsp_dsp)
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	for file in "${ED}/usr/$(get_libdir)/zrythm/carla/"*; do
		rm "${file}" || die
		dosym "../../carla/${file##*/}" "${file##${ED}}"
	done
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
