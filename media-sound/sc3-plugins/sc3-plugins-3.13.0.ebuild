# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Third party plugins for SuperCollider"
HOMEPAGE="https://github.com/supercollider/sc3-plugins"
SRC_URI="https://github.com/supercollider/${PN}/releases/download/Version-${PV}/${P}-Source.tar.bz2 -> ${P}.tar.bz2"

IUSE="debug ladspa supernova"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/${P}-Source"

RDEPEND="media-sound/supercollider"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DSC_PATH=/usr/include/SuperCollider
		-DLADSPA="$(usex ladspa ON OFF)"
		-DSUPERNOVA="$(usex supernova ON OFF)"
	)

	[[ "$(get_libdir)" == "lib64" ]] && mycmakeargs+=(
		-DLIB_SUFFIX=64
	)

	append-cppflags $(usex debug '' -DNDEBUG)

	cmake_src_configure
}
