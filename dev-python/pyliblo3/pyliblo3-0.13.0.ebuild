# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )
inherit distutils-r1 pypi

DESCRIPTION="Python bindings for the liblo OSC library"
HOMEPAGE="https://pypi.org/project/pyliblo3/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
# No tests in pypi tarball and no git tag for 0.13.0
RESTRICT="test"

RDEPEND="
	media-libs/liblo
	!media-libs/pyliblo
"
BDEPEND="dev-python/cython[${PYTHON_USEDEP}]"

PATCHES=(
	"${FILESDIR}/${PN}-0.12.0-cython-3.patch"
)
