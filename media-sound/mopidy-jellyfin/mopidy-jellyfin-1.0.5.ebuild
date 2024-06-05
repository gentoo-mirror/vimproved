# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYPI_NO_NORMALIZE=1
PYPI_PN="Mopidy-Jellyfin"
PYTHON_COMPAT=( python3_12 )

inherit distutils-r1 pypi

DESCRIPTION="Mopidy extension for playing music from jellyfin"
HOMEPAGE="https://github.com/jellyfin/mopidy-jellyfin"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	dev-python/pykka[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/unidecode[${PYTHON_USEDEP}]
	dev-python/websocket-client[${PYTHON_USEDEP}]
	media-plugins/gst-plugins-meta[http]
	media-sound/mopidy[${PYTHON_USEDEP}]
"
