# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="Mopidy extension for ListenBrainz"
HOMEPAGE="https://mopidy.com/ext/listenbrainz/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/musicbrainzngs-0.7.1[${PYTHON_USEDEP}]
	>=dev-python/pykka-2.0.1[${PYTHON_USEDEP}]
	>=media-sound/mopidy-3.0.0[${PYTHON_USEDEP}]
"

distutils_enable_tests import-check
