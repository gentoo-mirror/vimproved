# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYPI_NO_NORMALIZE=1
PYPI_PN="Mopidy-MPD"
PYTHON_COMPAT=( python3_12 )

inherit distutils-r1 pypi

DESCRIPTION="Mopidy extension for controlling Mopidy from MPD clients"
HOMEPAGE="https://mopidy.com"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/pykka[${PYTHON_USEDEP}]
	media-sound/mopidy[${PYTHON_USEDEP}]
"
