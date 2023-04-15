# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{9..11} pypy3 )
inherit gnome2-utils meson python-any-r1 vala

DESCRIPTION="A beautiful GTK 4 terminal."
HOMEPAGE="https://gitlab.gnome.org/raggesilver/blackbox"
SRC_URI="https://gitlab.gnome.org/raggesilver/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/libgee
	gui-libs/libadwaita
	gui-libs/marble
	gui-libs/vte
"
RDEPEND="${DEPEND}"
DEPEND+="${PYTHON_DEPS}"

src_prepare() {
	default
	vala_setup
}

src_install() {
	meson_src_install
	mv "${ED}/usr/share/appdata" "${ED}/usr/share/mimeinfo" || die
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
