# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit zig

DESCRIPTION="A dynamic tiling Wayland compositor"
HOMEPAGE="https://github.com/riverwm/river/"
SRC_URI="https://github.com/riverwm/river/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="X +man"

DEPEND="
	dev-libs/libevdev
	dev-libs/libinput:=
	dev-libs/wayland
	gui-libs/wlroots:=[X?]
	X? ( x11-base/xwayland )
	x11-libs/libxkbcommon
	x11-libs/pixman
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/wayland-protocols
	|| (
		<=dev-lang/zig-0.11
		<=dev-lang/zig-bin-0.11
	)
	man? ( app-text/scdoc )
"

pkg_setup() {
	local ZIG_MAX="0.10"
	zig_pkg_setup
}

src_compile() {
	local ezigargs=(
		-Dman-pages=$(usex man true false)
		-Dxwayland=$(usex X true false)
	)

	zig_src_compile
}