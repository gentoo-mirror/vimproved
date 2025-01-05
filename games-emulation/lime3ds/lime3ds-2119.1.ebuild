# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Open-source Nintendo 3DS emulator"
HOMEPAGE="https://github.com/Lime3DS/lime3ds-archive"
SRC_URI="https://github.com/Lime3DS/lime3ds-archive/releases/download/${PV}/lime3ds-unified-source-${PV}.tar.xz
	-> ${P}.tar.xz"
S="${WORKDIR}/lime3ds-unified-source-${PV}"

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
	net-libs/enet:1.3=
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
	"${FILESDIR}/${P}-boost-fix.patch"
	"${FILESDIR}/${P}-boost-1.87.patch"
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
		-DLIME3DS_USE_PRECOMPILED_HEADERS=OFF
		-DLIME3DS_WARNINGS_AS_ERRORS=OFF
		-DUSE_SYSTEM_LIBS=ON
	)

	cmake_src_configure
}
