# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_12 )

inherit distutils-r1 pypi

DESCRIPTION="Distributed self-replicating programs in Python"
HOMEPAGE="https://pypi.org/project/mitogen/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

PATCHES=( "${FILESDIR}/${P}-ansible-2.17.patch" )
