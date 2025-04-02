# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A dynamic recompiler for ARM."
HOMEPAGE="https://github.com/rtiangha/dynarmic"
SRC_URI="https://github.com/rtiangha/dynarmic/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/robin-map
	dev-libs/boost
	dev-libs/libfmt
	dev-libs/mcl
"
DEPEND="
	${RDEPEND}
	amd64? (
		dev-libs/xbyak
		dev-libs/zydis
	)
	arm64? ( dev-libs/oaknut )
	test? (
		=dev-cpp/catch-3*
		dev-libs/oaknut
	)
"

src_prepare() {
	rm -r externals/{catch,fmt,mcl,oaknut,robin-map,xbyak,zycore,zydis} ||
		die "removing bundled dependencies failed"
	cmake_src_prepare

	sed -i 's/0.1.12 EXACT//' CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DDYNARMIC_TESTS=$(usex test)
		-DDYNARMIC_USE_PRECOMPILED_HEADERS=OFF
		-DDYNARMIC_WARNINGS_AS_ERRORS=OFF
	)

	cmake_src_configure
}
