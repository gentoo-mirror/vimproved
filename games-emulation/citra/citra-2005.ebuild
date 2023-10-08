# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake

MY_PV="20231006-7931aac"

DESCRIPTION="A Nintendo 3DS Emulator"
HOMEPAGE="https://citra-emu.org/"
SRC_URI="https://github.com/${PN}-emu/${PN}-nightly/releases/download/nightly-${PV}/citra-unified-source-${MY_PV}.tar.xz -> ${P}.tar.xz"

IUSE="+qt6 +sdl"
LICENSE="GPL-2"
SLOT="0"
S="${WORKDIR}/${PN}-unified-source-${MY_PV}"

DEPEND="
	dev-cpp/cpp-httplib
	dev-cpp/nlohmann_json
	dev-cpp/robin-map
	dev-libs/boost[nls]
	dev-libs/dynarmic
	dev-libs/libfmt:=
	dev-libs/openssl
	media-libs/libsoundtouch
	qt6? (
		dev-qt/qtbase:6[concurrent,dbus,widgets]
		dev-qt/qtmultimedia:6
	)
	sdl? ( media-libs/libsdl2 )
"
RDEPEND="${DEPEND}"
BDEPEND="dev-util/glslang"

PATCHES=(
	"${FILESDIR}/${P}-system-dynarmic.patch"
	"${FILESDIR}/${P}-system-fmt.patch"
)

src_configure() {
	local mycmakeargs=(
		-DCITRA_ENABLE_BUNDLE_TARGET=OFF
		-DENABLE_QT=$(usex qt6)
		-DENABLE_SDL2=$(usex sdl)
		-DENABLE_WEB_SERVICE=OFF
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_SYSTEM_CPP_HTTPLIB=ON
		-DUSE_SYSTEM_DYNARMIC=ON
		-DUSE_SYSTEM_FMT=ON
		-DUSE_SYSTEM_JSON=ON
		-DUSE_SYSTEM_OPENSSL=ON
		-DUSE_SYSTEM_SDL2=ON
		-DUSE_SYSTEM_SOUNDTOUCH=ON
	)

	cmake_src_configure
}
