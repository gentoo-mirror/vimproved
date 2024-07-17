# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{11..12} )

inherit distutils-r1 pypi

DESCRIPTION="An efficient implementation of a rate limiter for asyncio."
HOMEPAGE="https://pypi.org/project/aiolimiter/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
# Tests broken (?)
# TODO: look into this more
RESTRICT="test"
