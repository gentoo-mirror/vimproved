# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_12 )
inherit distutils-r1

DESCRIPTION="Python implementation of the Language Server Protocol."
HOMEPAGE="https://github.com/microsoft/lsprotocol"
SRC_URI="https://github.com/microsoft/lsprotocol/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/cattrs[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
"
BDEPEND="test? ( dev-python/pyhamcrest[${PYTHON_USEDEP}] )"

distutils_enable_tests pytest
