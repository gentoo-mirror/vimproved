# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit gnome.org meson vala

DESCRIPTION="A set of programs to inspect and build Windows Installer (.MSI) files"
HOMEPAGE="https://wiki.gnome.org/msitools"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+introspection"

DEPEND="
	dev-libs/gcab[introspection?]
	dev-libs/glib
	dev-libs/libxml2
	introspection? ( dev-libs/gobject-introspection )
	gnome-extra/libgsf
"
RDEPEND="${DEPEND}"

src_prepare() {
	use introspection && vala_setup
	default
}

src_configure() {
	local emesonargs=(
		$(meson_use introspection)
	)
	meson_src_configure
}
