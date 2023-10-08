# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake xdg

MY_PV="20231006-7931aac"

DESCRIPTION="A Nintendo 3DS Emulator"
HOMEPAGE="https://citra-emu.org/"
SRC_URI="https://github.com/${PN}-emu/${PN}-nightly/releases/download/nightly-${PV}/citra-unified-source-${MY_PV}.tar.xz -> ${P}.tar.xz"

IUSE="+qt6 +sdl"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/${PN}-unified-source-${MY_PV}"

DEPEND="
	dev-cpp/nlohmann_json
	dev-cpp/robin-map
	dev-libs/boost:=[nls]
	dev-libs/dynarmic
	dev-libs/libfmt:=
	dev-libs/openssl:=
	dev-util/glslang:=
	media-libs/libsoundtouch:=
	qt6? (
		dev-qt/qtbase:6[concurrent,dbus,widgets]
		dev-qt/qtmultimedia:6
	)
	sdl? ( media-libs/libsdl2 )
"
RDEPEND="${DEPEND}"
BDEPEND="
	media-libs/fdk-aac
	media-video/ffmpeg
	x11-libs/libX11
"

PATCHES=(
	"${FILESDIR}/${P}-system-dynarmic.patch"
	"${FILESDIR}/${P}-system-fmt.patch"
)

src_prepare() {
	for dep in boost cpp-jwt dynarmic fmt json library-headers/library-headers libressl sdl2 soundtouch; do
		rm -rf "externals/${dep}" || die
	done

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DCITRA_ENABLE_BUNDLE_TARGET=OFF
		-DENABLE_QT=$(usex qt6)
		-DENABLE_SDL2=$(usex sdl)
		-DENABLE_WEB_SERVICE=OFF
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_SYSTEM_CPP_JWT=ON
		-DUSE_SYSTEM_DYNARMIC=ON
		-DUSE_SYSTEM_FMT=ON
		-DUSE_SYSTEM_JSON=ON
		-DUSE_SYSTEM_OPENSSL=ON
		-DUSE_SYSTEM_SDL2=ON
		-DUSE_SYSTEM_SOUNDTOUCH=ON
	)

	cmake_src_configure
}
