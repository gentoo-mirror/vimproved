# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson vala xdg

DESCRIPTION="Browse the Fediverse"
HOMEPAGE="https://tuba.geopjr.dev/"
SRC_URI="https://github.com/GeopJr/Tuba/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P^}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-crypt/libsecret[vala]
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libgee:0.8=
	dev-libs/libxml2
	gui-libs/gtk:4
	gui-libs/gtksourceview:5
	gui-libs/libadwaita:1[vala]
	net-libs/libsoup:3.0
	x11-libs/gdk-pixbuf:2
	x11-libs/pango
"
DEPEND="${RDEPEND}"

pkg_setup() {
	vala_setup
}

src_configure() {
	local emesonargs=(
		-Ddistro=true
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
