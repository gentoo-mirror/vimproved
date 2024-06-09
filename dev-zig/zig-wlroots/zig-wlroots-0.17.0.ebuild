# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit zig-package

DESCRIPTION="Zig bindings for wlroots"
HOMEPAGE="https://codeberg.org/ifreund/zig-wlroots"
SRC_URI="https://codeberg.org/ifreund/zig-wlroots/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="MIT"
KEYWORDS="~amd64"
RESTRICT="test"

DEPEND="
	dev-zig/zig-pixman:0.1.0
	dev-zig/zig-wayland:0.1.0
	dev-zig/zig-xkbcommon:0.1.0
"
