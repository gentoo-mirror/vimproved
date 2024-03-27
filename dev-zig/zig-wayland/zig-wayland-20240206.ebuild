# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit zig-package

DESCRIPTION="Zig wayland scanner and libwayland bindings"
HOMEPAGE="https://codeberg.org/ifreund/zig-wayland"
SRC_URI="https://codeberg.org/ifreund/${PN}/archive/e47e885f5361f7b4d25cc4a7ae856f276b314b34.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="MIT"
