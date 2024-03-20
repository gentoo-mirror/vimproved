# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11,12} )

inherit gnome2-utils meson python-single-r1 xdg

DESCRIPTION="Change the look of Adwaita, with ease"
HOMEPAGE="https://gradienceteam.github.io/"
MY_PV="$(ver_cut 1-3)-$(ver_cut 4-5)"
SUBMODULES_COMMIT="cc95cdf36c7c52ffa5d34dcf337e1523db89de26"
SRC_URI="
	https://github.com/${PN^}Team/${PN^}/archive/refs/tags/${MY_PV}.tar.gz -> ${P}.tar.gz
	https://github.com/${PN^}Team/Submodules/archive/${SUBMODULES_COMMIT}.tar.gz
		-> ${PN}-submodules-${SUBMODULES_COMMIT}.tar.gz
"
S="${WORKDIR}/Gradience-${MY_PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	dev-libs/libportal[gtk]
	gui-libs/gtk:4
	>=gui-libs/libadwaita-1.2
	>=net-libs/libsoup-3.2
	$(python_gen_cond_dep '
		dev-python/anyascii[${PYTHON_USEDEP}]
		dev-python/jinja[${PYTHON_USEDEP}]
		dev-python/libsass[${PYTHON_USEDEP}]
		dev-python/material-color-utilities-python[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/regex[${PYTHON_USEDEP}]
		dev-python/svglib[${PYTHON_USEDEP}]
		dev-python/yapsy[${PYTHON_USEDEP}]
	')
	${PYTHON_DEPS}
"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/blueprint-compiler"

src_prepare() {
	rm -rf data/submodules || die
	mv "${WORKDIR}/Submodules-${SUBMODULES_COMMIT}" data/submodules || die

	default
}

src_install() {
	meson_src_install

	python_optimize

	python_fix_shebang "${ED}/usr/bin/${PN}"
	python_fix_shebang "${ED}/usr/bin/${PN}-cli"

	mv "${ED}/usr/share/appdata" "${ED}/usr/share/metainfo" || die
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
