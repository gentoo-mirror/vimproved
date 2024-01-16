# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg

DESCRIPTION="A Nintendo 3DS Emulator"
HOMEPAGE="https://citra-emu.org/"
EGIT_REPO_URI="https://github.com/citra-emu/citra-nightly.git"
EGIT_SUBMODULES=( faad2 nihstro sirit teakra )

LICENSE="GPL-2"
SLOT="0"
IUSE="cubeb libusb +openal +qt6 +sdl +telemetry"
RESTRICT="test"

RDEPEND="
	app-arch/zstd
	dev-cpp/cpp-httplib:=
	dev-cpp/nlohmann_json
	dev-cpp/robin-map
	dev-libs/boost:=[nls]
	dev-libs/crypto++:=
	dev-libs/dynarmic
	dev-libs/inih
	dev-libs/libfmt:=
	dev-libs/openssl:=
	dev-libs/teakra
	dev-util/glslang:=
	dev-util/spirv-headers
	dev-util/vulkan-headers
	dev-util/vulkan-memory-allocator
	media-libs/libsoundtouch:=
	media-libs/lodepng
	net-libs/enet:=
	amd64? ( dev-libs/xbyak )
	cubeb? ( media-libs/cubeb )
	libusb? ( virtual/libusb:1 )
	openal? ( media-libs/openal )
	qt6? (
		dev-qt/qtbase:6[concurrent,widgets]
		dev-qt/qtmultimedia:6
	)
	sdl? ( media-libs/libsdl2 )
	telemetry? ( dev-cpp/cpp-jwt )
"
DEPEND="
	${RDEPEND}
	>=dev-cpp/catch-3
	media-video/ffmpeg
"

PATCHES=(
	"${FILESDIR}/citra-9999-fix-system-zstd.patch"
	"${FILESDIR}/citra-9999-system-teakra.patch"
)

src_prepare() {
	# Fool git detection
	rm -rf .git || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DCITRA_ENABLE_BUNDLE_TARGET=OFF
		-DCITRA_WARNINGS_AS_ERRORS=OFF
		-DENABLE_CUBEB=$(usex cubeb)
		-DENABLE_LIBUSB=$(usex libusb)
		-DENABLE_QT=$(usex qt6)
		-DENABLE_SDL2=$(usex sdl)
		-DENABLE_WEB_SERVICE=$(usex telemetry)
		-DSIRIT_USE_SYSTEM_SPIRV_HEADERS=ON
		-DUSE_SYSTEM_LIBS=ON
	)

	cmake_src_configure
}
