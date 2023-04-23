# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit meson

DESCRIPTION="A lightweight C99 portability and data structure library"
HOMEPAGE="https://gitlab.com/drobilla/zix"
MY_PV="262d4a1522c38be0588746e874159da5c7bb457d"
SRC_URI="https://gitlab.com/drobilla/zix/-/archive/${MY_PV}/zix-${MY_PV}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/zix-${MY_PV}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

BDEPEND="
	doc? (
		app-doc/doxygen
	)
"

src_configure() {
	local emesonargs=(
		$(meson_feature doc docs)
	)

	meson_src_configure
}
