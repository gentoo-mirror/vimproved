# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYPI_PN=discord-rpc.py
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="A Discord Rich Presence library for Python 2 & 3"
HOMEPAGE="https://pypi.org/project/discord-rpc.py/"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"

distutils_enable_tests import-check
