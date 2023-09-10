# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} pypy3 )
inherit distutils-r1

DESCRIPTION="Opinionated Batteries-Included Python 3 CLI Framework"
HOMEPAGE="https://milc.clueboard.co/"
SRC_URI="https://github.com/clueboard/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

IUSE="test"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/argcomplete[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/halo[${PYTHON_USEDEP}]
	dev-python/spinners[${PYTHON_USEDEP}]
	test? ( dev-python/semver[${PYTHON_USEDEP}] )
"

RESTRICT="!test? ( test )"

distutils_enable_tests pytest
