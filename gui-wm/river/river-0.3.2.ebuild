# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ZIG_MIN="0.12"
inherit zig-build

DESCRIPTION="A dynamic tiling Wayland compositor"
HOMEPAGE="https://isaacfreund.com/software/river/"
SRC_URI="https://codeberg.org/river/river/releases/download/v${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+X"
RESTRICT="test"

RDEPEND="
	dev-libs/libevdev
	>=gui-libs/wlroots-0.17.2[X?]
	<gui-libs/wlroots-0.18[X?]
	x11-libs/libxkbcommon
	x11-libs/pixman
"
DEPEND="
	${RDEPEND}
	dev-zig/zig-pixman:0.1.0
	dev-zig/zig-wayland:0.1.0
	dev-zig/zig-wlroots:0.17.0
	dev-zig/zig-xkbcommon:0.1.0
"
BDEPEND="
	app-text/scdoc
	virtual/pkgconfig
"

src_compile() {
	local ezigbuildargs=(
		$(usev X "-Dxwayland")
	)

	zig-build_src_compile
}
