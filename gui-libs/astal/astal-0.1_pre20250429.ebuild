# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_USE_DEPEND="valadoc"

inherit meson vala

DESCRIPTION="Building blocks for creating custom desktop shells"
HOMEPAGE="https://aylur.github.io/astal/"
ASTAL_COMMIT="07583deff8a486fad472718572c3248f0fbea1f3"
SRC_URI="https://github.com/Aylur/astal/archive/${ASTAL_COMMIT}.tar.gz
	-> astal-${ASTAL_COMMIT}.tar.gz"
S="${WORKDIR}/astal-${ASTAL_COMMIT}/lib/astal/gtk3"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

DEPEND="
	dev-libs/glib:2
	dev-libs/wayland
	~gui-libs/astal-io-${PV}
	gui-libs/gtk-layer-shell[vala]
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
"
RDEPEND="${DEPEND}"

src_configure() {
	vala_setup
	meson_src_configure
}
