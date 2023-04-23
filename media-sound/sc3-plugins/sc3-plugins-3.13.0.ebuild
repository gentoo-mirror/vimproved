# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake flag-o-matic

DESCRIPTION="Third party plugins for SuperCollider"
HOMEPAGE="https://github.com/supercollider/sc3-plugins"
SRC_URI="https://github.com/supercollider/sc3-plugins/releases/download/Version-${PV}/sc3-plugins-${PV}-Source.tar.bz2 -> ${P}.tar.bz2"
KEYWORDS="~amd64"
RESTRICT="mirror"
S="${WORKDIR}/${P}-Source"
LICENSE="GPL-2"
SLOT="0"
RESTRICT="mirror"

IUSE="debug ladspa supernova"

RDEPEND="
	media-sound/supercollider
"
DEPEND="${RDEPEND}
"

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
