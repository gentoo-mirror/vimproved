# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit zig-package

DESCRIPTION="Zig bindings for xkbcommon"
HOMEPAGE="https://codeberg.org/ifreund/zig-xkbcommon"
SRC_URI="https://codeberg.org/ifreund/zig-xkbcommon/archive/7b188de0ba794b52eb70340abf2469b858630816.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="MIT"
