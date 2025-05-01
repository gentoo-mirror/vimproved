# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Open-source Nintendo 3DS emulator"
HOMEPAGE="https://azahar-emu.org/"
MY_PV="20250414-00e3bbb"
SRC_URI="https://github.com/azahar-emu/azahar/releases/download/${PV}/azahar-unified-source-${MY_PV}.tar.xz
	-> ${P}.tar.xz"
S="${WORKDIR}/azahar-unified-source-${MY_PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-arch/zstd:=
	dev-libs/boost:=
	dev-libs/crypto++:=
	dev-libs/dynarmic
	dev-libs/libfmt:=
	dev-libs/openssl:=
	dev-qt/qtbase:6
	dev-qt/qtmultimedia:6
	dev-util/glslang:=
	media-libs/cubeb
	media-libs/libsdl2
	media-libs/libsoundtouch:=
	media-libs/lodepng
	media-libs/openal
	net-libs/enet:=
	virtual/libusb
"
DEPEND="
	${RDEPEND}
	=dev-cpp/catch-3*
	dev-cpp/cpp-httplib
	media-libs/cubeb
	media-libs/vma
"

PATCHES=(
	"${FILESDIR}/azahar-2120.2-boost-fix.patch"
	"${FILESDIR}/azahar-2120.2-boost-1.87.patch"
	"${FILESDIR}/azahar-2120.2-ffmpeg-7.patch"
)

src_prepare() {
	cp "${FILESDIR}/Findzstd.cmake" externals/cmake-modules/ || die "copying Findzstd.cmake failed"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DENABLE_LTO=OFF
		-DENABLE_WEB_SERVICE=OFF
		-DCITRA_USE_PRECOMPILED_HEADERS=OFF
		-DCITRA_WARNINGS_AS_ERRORS=OFF
		-DUSE_SYSTEM_LIBS=ON
	)

	cmake_src_configure
}
