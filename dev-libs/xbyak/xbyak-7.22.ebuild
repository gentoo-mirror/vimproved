# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A JIT assembler for x86/x64"
HOMEPAGE="https://github.com/herumi/xbyak"
SRC_URI="https://github.com/herumi/xbyak/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
