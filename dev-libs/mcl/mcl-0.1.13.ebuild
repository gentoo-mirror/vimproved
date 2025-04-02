# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="merry's common library"
HOMEPAGE="https://github.com/merryhime/mcl"
SRC_URI="https://github.com/merryhime/mcl/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-libs/libfmt:="
DEPEND="
	${RDEPEND}
	=dev-cpp/catch-3*
"

PATCHES=(
	"${FILESDIR}/mcl-0.1.13-lift_sequence.patch"
)

src_configure() {
	local mycmakeargs=(
		-DMCL_WARNINGS_AS_ERRORS=OFF
	)

	cmake_src_configure
}

src_test() {
	"${BUILD_DIR}/tests/mcl-tests" || die "tests failed"
}
