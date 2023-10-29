# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )
inherit distutils-r1 pypi

DESCRIPTION="Command-Line Installer and Manager for Celeste Modding"
HOMEPAGE="https://github.com/coloursofnoise/mons"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/dnfile[${PYTHON_USEDEP}]
	dev-python/pefile[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/xxhash[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest
