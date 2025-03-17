# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="A scriptable music downloader for Qobuz, Tidal, SoundCloud, and Deezer"
HOMEPAGE="https://pypi.org/project/streamrip/"
SRC_URI="https://github.com/nathom/streamrip/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/aiodns[${PYTHON_USEDEP}]
	dev-python/aiofiles[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/aiolimiter[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/cleo[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/click-help-colors[${PYTHON_USEDEP}]
	dev-python/deezer-py[${PYTHON_USEDEP}]
	dev-python/m3u8[${PYTHON_USEDEP}]
	dev-python/pathvalidate[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/simple-term-menu[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]
	${PYTHON_DEPS}
"

src_prepare() {
	sed -i 's/Cryptodome/Crypto/' \
		"${S}/${PN}/client/deezer.py" \
		"${S}/${PN}/client/downloadable.py"

	default
}

distutils_enable_tests pytest
