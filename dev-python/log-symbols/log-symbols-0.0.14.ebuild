# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} pypy3 )
inherit distutils-r1 pypi

DESCRIPTION="Colored symbols for various log levels for Python"
HOMEPAGE="https://pypi.org/project/log-symbols/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# Uses deprecated dev-python/nose
RESTRICT="test"

RDEPEND="dev-python/colorama[${PYTHON_USEDEP}]"
