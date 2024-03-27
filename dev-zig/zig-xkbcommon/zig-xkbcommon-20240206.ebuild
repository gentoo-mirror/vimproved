# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit zig-package

DESCRIPTION="Zig bindings for xkbcommon"
HOMEPAGE="https://codeberg.org/ifreund/zig-xkbcommon"
SRC_URI="https://codeberg.org/ifreund/zig-xkbcommon/archive/3a2eefdad6b4d48757274061dd2b5df3b89a2bfd.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="MIT"
