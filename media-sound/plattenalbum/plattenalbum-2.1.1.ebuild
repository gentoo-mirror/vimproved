# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )

inherit gnome2-utils meson python-single-r1 xdg

DESCRIPTION="Connect to your music"
HOMEPAGE="https://github.com/SoongNoonien/plattenalbum"
SRC_URI="https://github.com/SoongNoonien/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="test"

RDEPEND="
	gui-libs/gtk
	gui-libs/libadwaita

	$(python_gen_cond_dep '
		dev-python/python-mpd2[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
	')

	${PYTHON_DEPS}
"
BDEPEND="
	dev-build/meson
	dev-libs/glib:2
	sys-devel/gettext
"

src_install() {
	meson_src_install
	python_fix_shebang "${ED}"
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postinst
	gnome2_schemas_update
}
