# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python Library for Tom's Obvious, Minimal Language"
HOMEPAGE="https://pypi.org/project/toml/"
TOML_TEST_PV="1.5.0"
SRC_URI+=" https://github.com/toml-lang/toml-test/archive/refs/tags/v${TOML_TEST_PV}.tar.gz -> toml-test-${TOML_TEST_PV}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	mv "${WORKDIR}/toml-test-${TOML_TEST_PV}" toml-test || die
	distutils-r1_src_prepare
}

distutils_enable_tests pytest
