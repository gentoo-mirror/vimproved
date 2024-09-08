# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..12} )

inherit python-single-r1

DESCRIPTION="A tool to work with Ren'Py archives."
HOMEPAGE="https://github.com/Shizmob/rpatool"
RPATOOL_COMMIT="74f26d5dfdd645483e02552aa766ca447ad6b191"
SRC_URI="https://github.com/shizmob/rpatool/archive/${RPATOOL_COMMIT}.tar.gz -> rpatool-${RPATOOL_COMMIT}.tar.gz"
S="${WORKDIR}/rpatool-${RPATOOL_COMMIT}"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RESTRICT="!test? ( test )"

RDEPEND="${PYTHON_DEPS}"
BDEPEND="
	test? ( $(python_gen_cond_dep '
		dev-python/pytest-import-check[${PYTHON_USEDEP}]
	') )
"

src_test() {
	ln -s rpatool rpatool.py || die

	epytest --import-check rpatool.py
}

src_install() {
	default

	python_doscript rpatool
}
