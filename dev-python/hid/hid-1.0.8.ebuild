# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..14} )

inherit distutils-r1 pypi

DESCRIPTION="ctypes bindings for hidapi"
HOMEPAGE="https://pypi.org/project/hid/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/hidapi"
RDEPEND="${DEPEND}"

distutils_enable_tests import-check
