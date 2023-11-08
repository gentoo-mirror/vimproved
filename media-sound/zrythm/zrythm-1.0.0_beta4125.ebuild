# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson xdg

BETA_PV="$(ver_cut 5)"
MY_PV="$(ver_cut 1-3)-beta.${BETA_PV:0:1}.${BETA_PV:1:2}.${BETA_PV:3:4}"

DESCRIPTION="A highly automated and intuitive digital audio workstation"
HOMEPAGE="https://www.zrythm.org/"
SRC_URI="https://www.zrythm.org/releases/zrythm-${MY_PV}.tar.xz -> ${P}.tar.xz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X alsa graphviz +guile +jack +lsp-dsp +plugins profile pulseaudio rtaudio rtmidi sdl"
S="${WORKDIR}/zrythm-${MY_PV}"

RDEPEND="
	app-arch/zstd:=
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libbacktrace
	dev-libs/libcyaml
	dev-libs/libpcre
	dev-libs/libpcre2:=
	dev-libs/reproc
	dev-libs/serd
	dev-libs/xxhash
	dev-libs/zix
	>=gui-libs/gtk-4.10:4
	gui-libs/gtksourceview:5
	gui-libs/libadwaita:1
	gui-libs/libpanel:1
	kde-frameworks/breeze-icons
	>=media-libs/libsndfile-1.0.29
	media-libs/fontconfig
	media-libs/graphene
	media-libs/lilv
	media-libs/rubberband
	media-libs/soxr
	media-libs/sratom
	media-libs/vamp-plugin-sdk
	>=media-sound/carla-2.6
	net-misc/curl
	sci-libs/fftw:3.0=
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
	graphviz? ( media-gfx/graphviz )
	guile? ( dev-scheme/guile:12= )
	jack? ( virtual/jack )
	lsp-dsp? ( media-libs/lsp-dsp-lib )
	pulseaudio? ( media-libs/libpulse )
	rtaudio? ( media-libs/rtaudio )
	rtmidi? ( media-libs/rtmidi )
	sdl? ( media-libs/libsdl2 )
"
DEPEND="
	${RDEPEND}
	plugins? ( dev-libs/boost )
"
BDEPEND="
	dev-lang/sassc
	dev-scheme/guile
	x11-misc/xdg-utils
"

PATCHES=(
	"${FILESDIR}/zrythm-1.0.0_beta4125-remove-execinfo.patch"
)

src_configure() {
	local emesonargs=(
		-Dbuild_plugins_with_static_libs=false
		-Dcarla_use_cv32_patchbay_variant=true
		-Dcheck_updates=false
		-Dcompletions=false
		-Dopus=true
		$(meson_feature X x11)
		$(meson_feature alsa)
		$(meson_feature graphviz)
		$(meson_feature guile)
		$(meson_feature lsp-dsp lsp_dsp)
		$(meson_use plugins bundled_plugins)
		$(meson_use profile profiling)
		$(meson_feature pulseaudio pulse)
		$(meson_feature rtaudio)
		$(meson_feature rtmidi)
		$(meson_feature sdl)
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	rm -rf "${ED}/usr/$(get_libdir)/zrythm/carla" || die
	dosym "../carla" "/usr/$(get_libdir)/zrythm/carla"
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
