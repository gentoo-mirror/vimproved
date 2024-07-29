# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_12 )

inherit distutils-r1

DESCRIPTION="Distributed self-replicating programs in Python"
HOMEPAGE="https://pypi.org/project/mitogen/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mitogen-hq/mitogen.git"
else
	inherit pypi
	KEYWORDS="~amd64"
fi

LICENSE="BSD"
SLOT="0"
RESTRICT="test"

PATCHES=(
	"${FILESDIR}/mitogen-0.3.7-ansible-2.17.patch"
)
