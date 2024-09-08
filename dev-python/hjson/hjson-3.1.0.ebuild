# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="A user interface for JSON."
HOMEPAGE="https://pypi.org/project/hjson/"
HJSON_COMMIT="1687b811fcbbc54b5ac71cfbaa99f805e406fbcb"
SRC_URI="https://github.com/hjson/hjson-py/archive/${HJSON_COMMIT}.tar.gz -> hjson-${HJSON_COMMIT}.gh.tar.gz"
S="${WORKDIR}/hjson-py-${HJSON_COMMIT}"

LICENSE="AFL-2.1 MIT"
SLOT="0"
KEYWORDS="~amd64"

distutils_enable_tests unittest
