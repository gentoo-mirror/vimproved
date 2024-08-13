# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_12 )
inherit distutils-r1 pypi

DESCRIPTION="Ruff linting plugin for pylsp"
HOMEPAGE="https://pypi.org/project/python-lsp-ruff/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# TODO: tests
RESTRICT="test"

RDEPEND="
	dev-python/cattrs[${PYTHON_USEDEP}]
	dev-python/lsprotocol[${PYTHON_USEDEP}]
	dev-python/python-lsp-server[${PYTHON_USEDEP}]
	dev-util/ruff
"
