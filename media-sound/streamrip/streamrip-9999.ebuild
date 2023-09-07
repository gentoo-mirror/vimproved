# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..11} )

inherit distutils-r1 git-r3

DESCRIPTION="A scriptable music downloader for Qobuz, Tidal, SoundCloud, and Deezer"
HOMEPAGE="https://github.com/nathom/streamrip"
EGIT_REPO_URI="https://github.com/nathom/streamrip.git"
EGIT_BRANCH="dev"

LICENSE="GPL-3"
SLOT="0"

# Required packaging extra stuff. Can't be assed.
RESTRICT="test"

RDEPEND="
	dev-python/aiodns[${PYTHON_USEDEP}]
	dev-python/aiofiles[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/cleo[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/deezer-py[${PYTHON_USEDEP}]
	dev-python/m3u8[${PYTHON_USEDEP}]
	dev-python/pathvalidate[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/simple-term-menu[${PYTHON_USEDEP}]
	dev-python/tomlkit[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]
"

src_prepare() {
	sed -i 's/Cryptodome/Crypto/' \
		"${S}/streamrip/downloadtools.py" \
		"${S}/streamrip/clients.py"

	default
}
