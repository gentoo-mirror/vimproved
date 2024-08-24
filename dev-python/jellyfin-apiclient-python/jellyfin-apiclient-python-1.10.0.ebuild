# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_12 )

inherit distutils-r1

DESCRIPTION="Python API Client for Jellyfin"
HOMEPAGE="https://github.com/jellyfin/jellyfin-apiclient-python/"
SRC_URI="https://github.com/jellyfin/jellyfin-apiclient-python/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

PATCHES=(
	"${FILESDIR}/jellyfin-apiclient-python-1.10.0-setuptools-pyproject.patch"
)

RDEPEND="
	dev-python/certifi[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
	dev-python/websocket-client[${PYTHON_USEDEP}]
"