# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A cross-platform (C99/C++11) process library"
HOMEPAGE="https://github.com/DaanDeMeyer/reproc/"
SRC_URI="https://github.com/DaanDeMeyer/reproc/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cxx examples test"
RESTRICT="!test? ( test )"

src_configure() {
	local mycmakeargs=(
		-DREPROC++=$(usex cxx)
		-DREPROC_EXAMPLES=$(usex examples)
		-DREPROC_TEST=$(usex test)
	)

	cmake_src_configure
}
