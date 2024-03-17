# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit zig

DESCRIPTION="A dynamic tiling Wayland compositor"
HOMEPAGE="https://github.com/riverwm/river/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/riverwm/river.git"
	inherit git-r3
else
	SRC_URI="https://github.com/riverwm/river/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="X +man"
RESTRICT="test"

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
	man? ( app-text/scdoc )
"

src_compile() {
	local ezigargs=(
		-Dman-pages=$(usex man true false)
		-Dxwayland=$(usex X true false)
	)

	zig_src_compile
}
