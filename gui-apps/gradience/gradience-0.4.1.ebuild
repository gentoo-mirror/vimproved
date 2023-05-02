# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..11} )

inherit gnome2-utils meson python-single-r1 xdg

DESCRIPTION="Change the look of Adwaita, with ease"
HOMEPAGE="https://github.com/GradienceTeam/Gradience"
SRC_URI="https://github.com/GradienceTeam/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
IUSE=""
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

BDEPEND="
	dev-libs/gobject-introspection
	dev-util/blueprint-compiler
	dev-lang/sassc
"

DEPEND="
	dev-libs/glib:2
	>=gui-libs/gtk-4.5.0:4
	>=gui-libs/libadwaita-1.2:1=
	>=net-libs/libsoup-3.2.0:3.0
"
RDEPEND="
	${PYTHON_DEPS}
	${DEPEND}
	$(python_gen_cond_dep '
		dev-python/aiohttp[${PYTHON_USEDEP}]
		>=dev-python/anyascii-0.3[${PYTHON_USEDEP}]
		dev-python/cssutils[${PYTHON_USEDEP}]
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/material-color-utilities[${PYTHON_USEDEP}]
		>=dev-python/pygobject-3.42.2:3[${PYTHON_USEDEP}]
		dev-python/svglib[${PYTHON_USEDEP}]
		dev-python/yapsy[${PYTHON_USEDEP}]
	')
	dev-libs/libportal[gtk]
"

S="${WORKDIR}"/Gradience-${PV}

src_prepare() {
	default
	xdg_environment_reset
}

src_install() {
	meson_src_install
	python_optimize
	mv "${ED}"/usr/share/appdata "${ED}"/usr/share/metainfo || die
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
