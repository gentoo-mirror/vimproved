# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit gnome.org meson vala

DESCRIPTION="A set of programs to inspect and build Windows Installer (.MSI) files"
HOMEPAGE="https://wiki.gnome.org/msitools"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+introspection"

DEPEND="
	app-arch/gcab[vala]
	gnome-extra/libgsf
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	vala_setup
}

src_configure() {
	local emesonargs=(
		$(meson_use introspection)
	)

	meson_src_configure
}
