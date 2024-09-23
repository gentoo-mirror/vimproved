# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson xdg

DESCRIPTION="A highly automated and intuitive digital audio workstation"
HOMEPAGE="https://www.zrythm.org/"
if [[ ${PV} = *_rc* ]]; then
	MY_PV="$(ver_cut 1-3)-rc.$(ver_cut 5)"
fi
SRC_URI="https://www.${PN}.org/releases/${PN}-${MY_PV}.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X alsa +jack +plugins pulseaudio sdl"

RDEPEND="
	app-arch/zstd:=
	dev-libs/libbacktrace
	dev-libs/libcyaml
	dev-libs/libpcre2:=
	dev-libs/xxhash
	dev-libs/zix
	>=gui-libs/gtk-4.14:4[X?]
	gui-libs/gtksourceview:5
	gui-libs/libadwaita:1
	gui-libs/libpanel:1
	>=media-libs/libsndfile-1.0.29
	media-libs/lsp-dsp-lib:=
	media-libs/rubberband
	media-libs/soxr
	media-libs/vamp-plugin-sdk
	>=media-sound/carla-2.6
	net-misc/curl
	sci-libs/fftw:3.0=[threads]
	jack? ( virtual/jack )
	plugins? ( dev-libs/boost )
	pulseaudio? ( media-libs/libpulse )
	sdl? ( media-libs/libsdl2 )
"
DEPEND="${RDEPEND}"
BDEPEND="
	dev-lang/sassc
	dev-scheme/guile
	x11-misc/xdg-utils
"

PATCHES=(
	"${FILESDIR}/${PN}-1.0.0_beta4125-remove-execinfo.patch"
	"${FILESDIR}/${PN}-1.0.0_rc1-dlfcn.h-include.patch"
)

src_configure() {
	local emesonargs=(
		-Dbuild_plugins_with_static_libs=false
		-Dcarla_use_cv32_patchbay_variant=true
		-Dcheck_updates=false
		-Dcompletions=false
		-Dlsp_dsp=enabled
		-Dopus=true
		$(meson_feature X x11)
		$(meson_feature alsa)
		$(meson_use plugins bundled_plugins)
		$(meson_feature pulseaudio pulse)
		$(meson_feature sdl)
	)

	meson_src_configure
}

src_test() {
	meson_src_test --no-suite "zrythm:data"
}

src_install() {
	meson_src_install
	rm -rf "${ED}/usr/$(get_libdir)/${PN}/carla" || die
	dosym "../carla" "/usr/$(get_libdir)/${PN}/carla"
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
