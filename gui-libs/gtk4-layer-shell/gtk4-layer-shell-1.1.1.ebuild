# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit meson python-any-r1 vala

DESCRIPTION="A library for using the Layer Shell Wayland protocol with GTK4."
HOMEPAGE="https://github.com/wmww/gtk4-layer-shell"
SRC_URI="https://github.com/wmww/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples doc test smoke-tests introspection vala"
REQUIRED_USE="vala? ( introspection )"
RESTRICT="!test? ( test )"

DEPEND=">=gui-libs/gtk-4.10.5[wayland]"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-libs/wayland-1.10.0
	>=dev-libs/wayland-protocols-1.16
	>=dev-util/wayland-scanner-1.10.0
	introspection? ( dev-libs/gobject-introspection )
	doc? ( dev-util/gtk-doc )
	smoke-tests? (
		dev-lang/luajit
		dev-lua/lgi
	)
	test? ( >=dev-lang/python-3.8.19 )
	vala? ( $(vala_depend) )
"

src_configure() {
	local emesonargs=(
		$(meson_use examples)
		$(meson_use doc docs)
		$(meson_use test tests)
		$(meson_use smoke-tests)
		$(meson_use introspection)
		$(meson_use vala vapi)
	)

	use vala && vala_setup
	meson_src_configure
}
