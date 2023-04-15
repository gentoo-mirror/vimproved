# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit meson vala

DESCRIPTION="A custom GTK library."
HOMEPAGE="https://gitlab.gnome.org/raggesilver/marble"
MY_PV="6dcc6fefa35f0151b0549c01bd774750fe6bdef8"
SRC_URI="https://gitlab.gnome.org/raggesilver/marble/-/archive/${MY_PV}/marble-${MY_PV}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/glib
	gui-libs/gtk
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/gobject-introspection
"

src_prepare() {
	default
	vala_setup
}
