# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN=Mopidy-Scrobbler
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="Mopidy extension for scrobbling played tracks to Last.fm"
HOMEPAGE="https://mopidy.com/ext/scrobbler/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	dev-python/pykka[${PYTHON_USEDEP}]
	dev-python/pylast[${PYTHON_USEDEP}]
	media-sound/mopidy[${PYTHON_USEDEP}]
"
