# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit gnome2-utils meson xdg

BETA_PV="$(ver_cut 5)"
MY_PV="$(ver_cut 1-3)-beta.${BETA_PV:0:1}.${BETA_PV:1:2}.${BETA_PV:3}"
DESCRIPTION="highly automated and intuitive digital audio workstation"
HOMEPAGE="https://zrythm.org/"
SRC_URI="https://www.zrythm.org/releases/${PN}-${MY_PV}.tar.xz -> ${P}.tar.xz"

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
	gui-libs/gtk
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
		-Dalsa=disabled
		-Dbuild_plugins_with_static_libs=false
		-Dbundled_plugins=false
		-Dcompletions=false
		-Dgraphviz=disabled
		-Dguile=disabled
		-Djack=disabled
		-Dlsp_dsp=disabled
		-Dpulse=disabled
		-Dx11=disabled
	)

	meson_src_configure
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
