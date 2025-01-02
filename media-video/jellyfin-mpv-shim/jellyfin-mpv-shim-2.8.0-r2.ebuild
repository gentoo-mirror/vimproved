# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{12..13} )
PYTHON_REQ_USE="tk(-)"

inherit distutils-r1 desktop pypi xdg

DESCRIPTION="MPV Cast Client for Jellyfin"
HOMEPAGE="https://github.com/jellyfin/jellyfin-mpv-shim"

LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="
	dev-python/jellyfin-apiclient-python[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pypresence[${PYTHON_USEDEP}]
	dev-python/pystray[${PYTHON_USEDEP}]
	dev-python/python-mpv[${PYTHON_USEDEP}]
	dev-python/python-mpv-jsonipc[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
"

src_install() {
	distutils-r1_src_install

	for size in 16 32 48 64 128 256; do
		doicon -s ${size} jellyfin_mpv_shim/integration/jellyfin-${size}.png
	done
	domenu jellyfin_mpv_shim/integration/com.github.iwalton3.jellyfin-mpv-shim.desktop
	insinto /usr/share/metainfo
	doins jellyfin_mpv_shim/integration/com.github.iwalton3.jellyfin-mpv-shim.appdata.xml
}
