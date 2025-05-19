# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_USE_DEPEND="valadoc"

inherit meson vala

DESCRIPTION="Building blocks for creating custom desktop shells"
HOMEPAGE="https://aylur.github.io/astal/"
ASTAL_COMMIT="4820a3e37cc8eb81db6ed991528fb23472a8e4de"
SRC_URI="https://github.com/Aylur/astal/archive/${ASTAL_COMMIT}.tar.gz
	-> astal-${ASTAL_COMMIT}.tar.gz"
S="${WORKDIR}/astal-${ASTAL_COMMIT}/lib/astal/io"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

DEPEND="dev-libs/glib:2"
RDEPEND="${DEPEND}"
BDEPEND="$(vala_depend)"

src_configure() {
	vala_setup
	meson_src_configure
}
