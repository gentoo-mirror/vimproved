# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS="bdepend"
PYTHON_COMPAT=( python3_{10..11} )
inherit distutils-r1 pypi

DESCRIPTION="Unofficial client for the Porkbun API"
HOMEPAGE="https://pypi.org/project/pkb-client/"
SRC_URI="https://github.com/infinityofspace/pkb_client/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]"

src_prepare() {
	rm -rf "${S}/tests" || die
	default
}
