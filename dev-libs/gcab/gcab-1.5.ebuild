# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RESTRICT="!test? ( test )"
inherit meson vala

DESCRIPTION="A GObject library to create cabinet files"
HOMEPAGE="https://gitlab.gnome.org/GNOME/gcab"
SRC_URI="https://gitlab.gnome.org/GNOME/gcab/-/archive/v${PV}/gcab-v${PV}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk-doc +introspection nls test +vala"

DEPEND="
	introspection? ( dev-libs/gobject-introspection )
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-fix-build.patch"
)

src_prepare() {
	use vala && vala_setup
	default
}

src_configure() {
	local emesonargs=(
		$(meson_use gtk-doc docs)
		$(meson_use introspection)
		$(meson_use nls)
		$(meson_use test tests)
		$(meson_use vala vapi)
	)
	meson_src_configure
}
