# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A runtime code generator for RISC-V"
HOMEPAGE="https://github.com/lioncash/biscuit/"
SRC_URI="https://github.com/lioncash/biscuit/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
