# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit zig-package

DESCRIPTION="Zig wayland scanner and libwayland bindings"
HOMEPAGE="https://codeberg.org/ifreund/zig-wayland"
SRC_URI="https://codeberg.org/ifreund/${PN}/archive/343c2e30d838b7765c9a5c5bfc31baf18b564a9a.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="MIT"
