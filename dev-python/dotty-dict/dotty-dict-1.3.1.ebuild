# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Dictionary wrapper for quick access to deeply nested keys."
HOMEPAGE="https://pypi.org/project/dotty-dict/"
SRC_URI="https://github.com/pawelzny/$(pypi_normalize_name "${PN}")/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests pytest
