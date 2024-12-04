# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="A Python package which creates simple interactive menus on the command line."
HOMEPAGE="https://pypi.org/project/simple-term-menu/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests import-check
