# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_13 )

inherit distutils-r1 pypi

DESCRIPTION="Python API to MPV using JSON IPC"
HOMEPAGE="https://pypi.org/project/python-mpv-jsonipc/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests import-check
