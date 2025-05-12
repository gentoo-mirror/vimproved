# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

DESCRIPTION="A translator from DBusMenu to GMenuModel"
HOMEPAGE="https://gitlab.com/vala-panel-project/vala-panel-appmenu"
SRC_URI="https://gitlab.com/vala-panel-project/vala-panel-appmenu/-/archive/${PV}/vala-panel-appmenu-${PV}.tar.bz2"
S="${WORKDIR}/vala-panel-appmenu-${PV}/subprojects/${PN}"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/glib:2
	x11-libs/gdk-pixbuf
"
RDEPEND="${DEPEND}"

src_configure() {
	vala_setup
	meson_src_configure
}
