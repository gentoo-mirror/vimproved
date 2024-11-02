# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Application based on SDL2 that turns your desktop audio into awesome visuals"
HOMEPAGE="https://github.com/projectM-visualizer/frontend-sdl2"
COMMIT="df6bfb51d7be335b4c258e2085f13d14e27f14a9"
IMGUI_COMMIT="d6cb3c923d28dcebb2d8d9605ccc7229ccef19eb"
SRC_URI="
	https://github.com/projectM-visualizer/frontend-sdl2/archive/${COMMIT}.tar.gz
		-> frontend-sdl2-${COMMIT}.tar.gz
	https://github.com/ocornut/imgui/archive/${IMGUI_COMMIT}.tar.gz
		-> imgui-${IMGUI_COMMIT}.tar.gz
"
S="${WORKDIR}/frontend-sdl2-${COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/poco
	media-libs/libprojectm
	media-libs/libsdl2
"
DEPEND="${RDEPEND}"

src_prepare() {
	rm -r vendor/imgui || die
	mv "${WORKDIR}/imgui-${IMGUI_COMMIT}" vendor/imgui || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_DESKTOP_ICON=OFF
	)

	cmake_src_configure
}
