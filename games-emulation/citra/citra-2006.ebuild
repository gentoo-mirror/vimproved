# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake xdg

MY_PV="20231008-f5b8888"

DESCRIPTION="A Nintendo 3DS Emulator"
HOMEPAGE="https://citra-emu.org/"
SRC_URI="https://github.com/${PN}-emu/${PN}-nightly/releases/download/nightly-${PV}/citra-unified-source-${MY_PV}.tar.xz -> ${P}.tar.xz"

IUSE="cubeb +gui nls openal sdl +telemetry test usb"
REQUIRED_USE="|| ( gui sdl )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
S="${WORKDIR}/${PN}-unified-source-${MY_PV}"
RESTRICT="!test? ( test )"

DEPEND="
	dev-cpp/nlohmann_json
	dev-cpp/robin-map
	dev-libs/boost:=[nls]
	dev-libs/dynarmic
	dev-libs/libfmt:=
	dev-libs/openssl:=
	dev-util/glslang:=
	media-libs/libsoundtouch:=
	gui? (
		dev-qt/qtbase:6[concurrent,dbus,widgets]
		dev-qt/qtmultimedia:6
	)
	sdl? ( media-libs/libsdl2 )
	usb? ( virtual/libusb )
"
RDEPEND="${DEPEND}"
BDEPEND="
	media-libs/fdk-aac
	media-video/ffmpeg
	x11-libs/libX11
"

src_prepare() {
	for dep in boost dynarmic fmt json library-headers/library-headers libressl libusb sdl2 soundtouch; do
		rm -rf "externals/${dep}" || die
	done

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DCITRA_ENABLE_BUNDLE_TARGET=OFF
		-DCITRA_WARNINGS_AS_ERRORS=OFF
		-DENABLE_CUBEB=$(usex cubeb)
		-DENABLE_LIBUSB=$(usex usb)
		-DENABLE_LTO=OFF
		-DENABLE_OPENAL=$(usex openal)
		-DENABLE_QT=$(usex gui)
		-DENABLE_QT_TRANSLATION=$(use gui && usex nls || echo OFF)
		-DENABLE_QT_UPDATER=OFF
		-DENABLE_SDL2=$(usex sdl)
		-DENABLE_TESTS=$(usex test)
		-DENABLE_WEB_SERVICE=$(usex telemetry)
		-DUSE_SYSTEM_BOOST=ON
		-DUSE_SYSTEM_DYNARMIC=ON
		-DUSE_SYSTEM_FMT=ON
		-DUSE_SYSTEM_JSON=ON
		-DUSE_SYSTEM_LIBUSB=ON
		-DUSE_SYSTEM_OPENSSL=ON
		-DUSE_SYSTEM_SDL2=ON
		-DUSE_SYSTEM_SOUNDTOUCH=ON
	)

	cmake_src_configure
}
