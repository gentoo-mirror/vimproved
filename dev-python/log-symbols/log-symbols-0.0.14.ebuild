# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{13..14} )

inherit distutils-r1

DESCRIPTION="Colored symbols for various log levels for Python"
HOMEPAGE="https://pypi.org/project/log-symbols/"
# No git tags and pypi releases do not provide tests.
LOG_SYMBOLS_COMMIT="eb527ec951e3d02c828efdb56e9f78e364c109b2"
SRC_URI="https://github.com/manrajgrover/py-log-symbols/archive/${LOG_SYMBOLS_COMMIT}.tar.gz -> log-symbols-${LOG_SYMBOLS_COMMIT}.tar.gz"
S="${WORKDIR}/py-log-symbols-${LOG_SYMBOLS_COMMIT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/colorama[${PYTHON_USEDEP}]"

distutils_enable_tests unittest
