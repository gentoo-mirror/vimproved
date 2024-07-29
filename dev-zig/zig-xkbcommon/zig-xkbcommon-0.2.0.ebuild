# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit zig-package

DESCRIPTION="Zig bindings for xkbcommon"
HOMEPAGE="https://codeberg.org/ifreund/zig-xkbcommon"
SRC_URI="https://codeberg.org/ifreund/zig-xkbcommon/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="MIT"
KEYWORDS="~amd64"
RESTRICT="test"
