# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_13 )

inherit distutils-r1 pypi

DESCRIPTION="Linter plugin for pylsp based on ruff."
HOMEPAGE="
	https://pypi.org/project/python-lsp-ruff/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/lsprotocol[${PYTHON_USEDEP}]
	dev-python/python-lsp-server[${PYTHON_USEDEP}]
	>=dev-util/ruff-0.2.0
"

PATCHES=(
	"${FILESDIR}/${P}-system-ruff-executable.patch"
)

# broken with the system ruff patch
EPYTEST_IGNORE=( tests/test_ruff_lint.py )

distutils_enable_tests pytest
