# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{9..12} pypy3 )
inherit distutils-r1 pypi

DESCRIPTION="ctypes bindings for hidapi"
HOMEPAGE="https://pypi.org/project/hid/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# No tests?
RESTRICT="test"

DEPEND="dev-libs/hidapi"
RDEPEND="${DEPEND}"
