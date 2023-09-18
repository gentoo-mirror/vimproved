# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit gnome2-utils meson

DESCRIPTION="Collection of card games"
HOMEPAGE="https://wiki.gnome.org/Apps/Aisleriot"
SRC_URI="https://gitlab.gnome.org/GNOME/aisleriot/-/archive/${PV}/${P}.tar.bz2"

IUSE="debug doc kde sound +svg"
LICENSE="GPL-3+ LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/glib:2
	dev-scheme/guile
	x11-libs/cairo
	x11-libs/gtk+:3
	kde? ( dev-qt/qtsvg )
	svg? ( gnome-base/librsvg )
	sound? ( media-libs/libcanberra[gtk3] )
"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/itstool"

src_configure() {
	local emesonargs=(
		$(meson_use debug dbg)
		$(meson_use debug dbgui)
		$(meson_use doc docs)
		$(meson_use sound)
		$(meson_use kde theme_kde)
		$(meson_use svg theme_svg_rsvg)
	)

	meson_src_configure
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
}
