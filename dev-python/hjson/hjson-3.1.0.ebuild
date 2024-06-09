# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 pypi

DESCRIPTION="A user interface for JSON."
HOMEPAGE="https://pypi.org/project/hjson/"

LICENSE="AFL-2.1 MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
