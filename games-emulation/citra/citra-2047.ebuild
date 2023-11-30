# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

MY_PV="20231129-0ed909e"

DESCRIPTION="A Nintendo 3DS Emulator"
HOMEPAGE="https://citra-emu.org/"
SRC_URI="https://github.com/citra-emu/citra-nightly/releases/download/nightly-${PV}/citra-unified-source-${MY_PV}.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}/citra-unified-source-${MY_PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cubeb libusb openal +qt6 +sdl +telemetry"
RESTRICT="test"

RDEPEND="
	>=dev-cpp/catch-3
	dev-cpp/cpp-httplib
	dev-cpp/nlohmann_json
	dev-cpp/robin-map
	dev-libs/boost[nls]
	dev-libs/crypto++
	dev-libs/dynarmic
	dev-libs/inih
	dev-libs/libfmt
	dev-libs/openssl
	dev-util/glslang
	dev-util/vulkan-headers
	dev-util/vulkan-memory-allocator
	media-libs/libsoundtouch
	media-libs/lodepng
	media-video/ffmpeg
	net-libs/enet
	amd64? ( dev-libs/xbyak )
	cubeb? ( media-libs/cubeb )
	libusb? ( virtual/libusb )
	openal? ( media-libs/openal )
	qt6? (
		dev-qt/qtbase:6[concurrent,widgets]
		dev-qt/qtmultimedia:6
	)
	sdl? ( media-libs/libsdl2 )
	telemetry? ( dev-cpp/cpp-jwt )
"

src_prepare() {
	cmake_src_prepare

	# Remove unused bundled dependencies
	rm -r externals/android-ifaddrs \
		externals/boost \
		externals/catch2 \
		externals/cpp-jwt \
		externals/cryptopp \
		externals/cryptopp-cmake \
		externals/cubeb \
		externals/discord-rpc \
		externals/dynarmic \
		externals/enet \
		externals/fmt \
		externals/getopt \
		externals/glslang \
		externals/httplib \
		externals/inih \
		externals/json \
		externals/libadrenotools \
		externals/library-headers \
		externals/libressl \
		externals/libusb \
		externals/libyuv \
		externals/lodepng \
		externals/openal-soft \
		externals/sdl2 \
		externals/soundtouch \
		externals/vma \
		externals/vulkan-headers \
		externals/xbyak || die
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
		-DUSE_SYSTEM_LIBS=ON
		-DDISABLE_SYSTEM_ZSTD=ON
	)

	cmake_src_configure
}
