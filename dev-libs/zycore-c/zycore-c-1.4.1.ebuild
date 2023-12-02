# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Platform independent types, macros and a fallback for environments without LibC."
HOMEPAGE="https://github.com/zyantific/zycore-c"
SRC_URI="https://github.com/zyantific/zycore-c/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples test"
RESTRICT="!test? ( test )"

DEPEND="test? ( dev-cpp/gtest )"
BDEPEND="doc? ( app-doc/doxygen )"

src_configure() {
	local mycmakeargs=(
		-DZYCORE_BUILD_EXAMPLES=$(usex examples)
		-DZYCORE_BUILD_SHARED_LIB=ON
		-DZYCORE_BUILD_TESTS=$(usex test)
		$(cmake_use_find_package doc Doxygen)
	)

	cmake_src_configure
}
