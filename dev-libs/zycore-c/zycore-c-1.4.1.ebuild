# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

DESCRIPTION="Internal library providing platform independent types and macros."
HOMEPAGE="https://github.com/zyantific/zycore-c"
SRC_URI="https://github.com/zyantific/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

IUSE="test"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-cpp/gtest )"

src_configure() {
	local mycmakeargs=(
		-DZYCORE_BUILD_SHARED_LIB=ON
		-DZYCORE_BUILD_TESTS=$(usex test)
	)

	cmake_src_configure
}
