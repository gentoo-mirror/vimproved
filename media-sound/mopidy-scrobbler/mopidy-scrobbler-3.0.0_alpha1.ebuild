# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{12..13} )

inherit distutils-r1 pypi

DESCRIPTION="Mopidy extension for scrobbling played tracks to Last.fm"
HOMEPAGE="https://mopidy.com/ext/scrobbler/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/pykka[${PYTHON_USEDEP}]
	>=dev-python/pylast-4.2[${PYTHON_USEDEP}]
	>=media-sound/mopidy-4.0.0_alpha3[${PYTHON_USEDEP}]
"

distutils_enable_tests import-check
