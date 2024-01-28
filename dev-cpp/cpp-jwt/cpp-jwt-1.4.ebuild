# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="JSON Web Token library for C++"
HOMEPAGE="https://github.com/arun11299/cpp-jwt/"
SRC_URI="https://github.com/arun11299/cpp-jwt/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-libs/openssl
	dev-cpp/nlohmann_json
	test? ( dev-cpp/gtest )
"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCPP_JWT_BUILD_EXAMPLES=$(usex examples)
		-DCPP_JWT_BUILD_TESTS=$(usex test)
		-DCPP_JWT_USE_VENDORED_NLOHMANN_JSON=OFF
	)
	cmake_src_configure
}
