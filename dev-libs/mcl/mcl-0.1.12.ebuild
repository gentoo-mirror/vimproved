# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="merry's common library"
HOMEPAGE="https://github.com/merryhime/mcl"
SRC_URI="https://github.com/merryhime/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

IUSE="test"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="!test? ( test )"

DEPEND=">=dev-libs/libfmt-9:="
RDEPEND="${DEPEND}"
BDEPEND="test? ( >=dev-cpp/catch-3 )"

src_configure() {
	local mycmakeargs=(
		-DMCL_WARNINGS_AS_ERRORS=OFF
	)

	cmake_src_configure
}

src_test() {
	"${BUILD_DIR}/tests/mcl-tests" || die
}