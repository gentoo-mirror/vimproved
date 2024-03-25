# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1

DESCRIPTION="Generate and change color-schemes on the fly. (16-color fork)"
HOMEPAGE="https://github.com/eylles/pywal16"
SRC_URI="https://github.com/eylles/pywal16/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

RDEPEND="media-gfx/imagemagick[jpeg]"
