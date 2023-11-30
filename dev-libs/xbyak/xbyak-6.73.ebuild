# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="a JIT assembler for x86(IA-32)/x64(AMD64, x86-64) by C++ header"
HOMEPAGE="https://github.com/herumi/xbyak"
SRC_URI="https://github.com/herumi/xbyak/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
