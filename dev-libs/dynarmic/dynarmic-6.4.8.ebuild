# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="An ARM dynamic recompiler."
HOMEPAGE="https://github.com/merryhime/dynarmic"
SRC_URI="https://github.com/merryhime/dynarmic/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-cpp/robin-map
	>=dev-libs/boost-1.57
	>=dev-libs/libfmt-9
	~dev-libs/mcl-0.1.12
	>=dev-libs/xbyak-6
	dev-libs/zydis
"
DEPEND="
	${RDEPEND}
	test? ( >=dev-cpp/catch-3 )
"

src_prepare() {
	cmake_src_prepare

	# Remove unused bundled deps
	rm -r externals/catch \
		externals/fmt \
		externals/mcl \
		externals/robin-map \
		externals/xbyak \
		externals/zycore \
		externals/zydis || die
}

src_configure() {
	local mycmakeargs=(
		-DDYNARMIC_TESTS=$(usex test)
		-DDYNARMIC_WARNINGS_AS_ERRORS=OFF
	)

	cmake_src_configure
}
