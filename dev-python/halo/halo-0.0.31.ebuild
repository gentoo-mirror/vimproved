# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Beautiful terminal spinners in Python"
HOMEPAGE="https://pypi.org/project/halo/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/log-symbols[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/spinners[${PYTHON_USEDEP}]
	dev-python/termcolor[${PYTHON_USEDEP}]
"
