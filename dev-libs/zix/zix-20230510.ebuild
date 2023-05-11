# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit meson

DESCRIPTION="A lightweight C99 portability and data structure library"
HOMEPAGE="https://gitlab.com/drobilla/zix"
ZIX_COMMIT="71b215560249747a2f1c3d16f9d372e5b668c45e"
SRC_URI="https://gitlab.com/drobilla/zix/-/archive/${ZIX_COMMIT}/zix-${ZIX_COMMIT}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/zix-${ZIX_COMMIT}"

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
