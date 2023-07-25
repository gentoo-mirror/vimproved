# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{10..11} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi

DESCRIPTION="Plugin for certbot to obtain certificates for Porkbun domains"
HOMEPAGE="https://github.com/infinityofspace/certbot_dns_porkbun"
SRC_URI="https://github.com/infinityofspace/certbot_dns_porkbun/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-crypt/certbot[${PYTHON_USEDEP}]
	dev-python/dnspython[${PYTHON_USEDEP}]
	dev-python/pkb-client[${PYTHON_USEDEP}]
"
