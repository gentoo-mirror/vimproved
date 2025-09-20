# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{13..14} )

inherit distutils-r1 pypi

DESCRIPTION="View/select the URLs in an email message or file"
HOMEPAGE="https://pypi.org/project/urlscan/"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/urwid[${PYTHON_USEDEP}]"

src_install() {
	distutils-r1_src_install
	rm -rf "${ED}/usr/share/doc/urlscan" || die
}

distutils_enable_tests import-check
