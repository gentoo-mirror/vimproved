# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_12 )
PYTHON_REQ_USE="tk(-)"

inherit distutils-r1 pypi xdg

DESCRIPTION="MPV Cast Client for Jellyfin"
HOMEPAGE="https://github.com/jellyfin/jellyfin-mpv-shim"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	dev-python/jellyfin-apiclient-python[${PYTHON_USEDEP}]
	dev-python/pystray[${PYTHON_USEDEP}]
	dev-python/python-mpv[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"
