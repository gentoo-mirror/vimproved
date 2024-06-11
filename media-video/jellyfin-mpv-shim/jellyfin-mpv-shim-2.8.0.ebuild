# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="setuptools"
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_12 )
PYTHON_REQ_USE="tk(-)"

inherit desktop distutils-r1 pypi xdg

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

src_install() {
	distutils-r1_src_install

	domenu "${S}/jellyfin_mpv_shim/integration/com.github.iwalton3.jellyfin-mpv-shim.desktop"
	doicon -s 16 "${S}/jellyfin_mpv_shim/integration/jellyfin-16.png"
	doicon -s 32 "${S}/jellyfin_mpv_shim/integration/jellyfin-32.png"
	doicon -s 48 "${S}/jellyfin_mpv_shim/integration/jellyfin-48.png"
	doicon -s 64 "${S}/jellyfin_mpv_shim/integration/jellyfin-64.png"
	doicon -s 128 "${S}/jellyfin_mpv_shim/integration/jellyfin-128.png"
	doicon -s 256 "${S}/jellyfin_mpv_shim/integration/jellyfin-256.png"
}
