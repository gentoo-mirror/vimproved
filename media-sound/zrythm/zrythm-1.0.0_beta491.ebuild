# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit gnome2-utils meson xdg

DESCRIPTION="A highly automated and intuitive digital audio workstation"
HOMEPAGE="https://www.zrythm.org/"
MY_BETA_PV="$(ver_cut 5)"
MY_PV="$(ver_cut 1-3)-beta.${MY_BETA_PV:0:1}.${MY_BETA_PV:1:1}.${MY_BETA_PV:2:2}"
MY_P="${PN}-${MY_PV}"
SRC_URI="https://www.zrythm.org/releases/${MY_P}.tar.xz"
S="${WORKDIR}/${MY_P}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror !test? ( test )"
IUSE="X alsa doc graphviz +guile +jack man optimize opus +plugins profile pulseaudio sdl +simd rtaudio test"

DEPEND="
	app-arch/zstd
	plugins? ( dev-libs/boost )
	dev-libs/json-glib
	dev-libs/libcyaml
	dev-libs/libpcre2
	dev-libs/reproc
	dev-libs/xxhash
	dev-libs/zix
	guile? ( dev-scheme/guile )
	gui-libs/gtk[X?]
	gui-libs/gtksourceview
	gui-libs/libadwaita
	gui-libs/libpanel
	kde-frameworks/breeze-icons
	graphviz? ( media-gfx/graphviz )
	media-libs/libaudec
	sdl? ( media-libs/libsdl2 )
	media-libs/lilv
	simd? ( media-libs/lsp-dsp-lib )
	rtaudio? (
		media-libs/rtaudio
		media-libs/rtmidi
	)
	media-libs/rubberband
	media-libs/vamp-plugin-sdk
	media-sound/carla
	net-misc/curl
	sci-libs/fftw[threads]
	sys-libs/libbacktrace
	jack? ( virtual/jack )
"
RDEPEND="${DEPEND}"
BDEPEND="x11-misc/xdg-utils"

PATCHES=(
	"${FILESDIR}/${PN}-1.0.0_beta491-cstdint.patch"
)

src_configure() {
	local emesonargs=(
		$(meson_use profile profiling)
		$(meson_use test tests)
		$(meson_use test gui_tests)
		$(meson_feature rtaudio)
		$(meson_feature rtaudio rtmidi)
		$(meson_feature sdl)
		$(meson_feature jack)
		$(meson_feature graphviz)
		$(meson_feature guile)
		$(meson_feature simd lsp_dsp)
		$(meson_use man manpage)
		$(meson_use doc user_manual)
		$(meson_use optimize extra_optimizations)
		$(meson_use optimize extra_extra_optimizations)
		$(meson_use opus)
		$(meson_use optimize native_build)
		$(meson_feature X x11)
		$(meson_feature alsa)
		$(meson_feature pulseaudio pulse)
		$(meson_use plugins bundled_plugins)
		-Dcheck_updates=false
	)

	meson_src_configure
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
