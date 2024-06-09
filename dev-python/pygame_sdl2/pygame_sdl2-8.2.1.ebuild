# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1

DESCRIPTION="Reimplementation of portions of the pygame API using SDL2"
HOMEPAGE="https://github.com/renpy/pygame_sdl2"
MY_P="${PN}-2.1.0+renpy${PV}"
SRC_URI="https://www.renpy.org/dl/${PV}/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-2.1 ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# <wheel-0.41.0 wasn't installing headers correctly
# https://github.com/pypa/setuptools/issues/3997
BDEPEND="
	>=dev-python/wheel-0.41.0
"
DEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	media-libs/libjpeg-turbo:=
	media-libs/libpng:0=
	media-libs/libsdl2:=[video]
	media-libs/sdl2-image:=[png,jpeg]
	>=media-libs/sdl2-mixer-2.0.2:=
	media-libs/sdl2-ttf:=
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-8.2.1-cython-3.patch"
)

python_prepare_all() {
	# PyGame distribution for this version has some pregenerated files;
	# we need to remove them
	rm -r gen{,3,-static} || die

	distutils-r1_python_prepare_all
}
