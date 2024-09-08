# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1

DESCRIPTION="Python m3u8 parser"
HOMEPAGE="https://github.com/globocom/m3u8/"
SRC_URI="https://github.com/globocom/m3u8/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/iso8601[${PYTHON_USEDEP}]"
BDEPEND="
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		${RDEPEND}
	)
"

python_test() {
	# Require network access
	local EPYTEST_DESELECT=(
		tests/test_loader.py::test_load_should_create_object_from_uri
		tests/test_loader.py::test_load_should_remember_redirect
		tests/test_loader.py::test_load_should_create_object_from_uri_with_relative_segments
		tests/test_loader.py::test_raise_timeout_exception_if_timeout_happens_when_loading_from_uri
	)

	epytest
}
