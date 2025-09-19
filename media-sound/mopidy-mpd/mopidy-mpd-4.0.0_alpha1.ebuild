# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_13 )

inherit distutils-r1 pypi

DESCRIPTION="Mopidy extension for controlling playback from MPD clients"
HOMEPAGE="https://mopidy.com/ext/mpd/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/pykka[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=media-sound/mopidy-4.0.0_alpha4[${PYTHON_USEDEP}]
"

distutils_enable_tests import-check
