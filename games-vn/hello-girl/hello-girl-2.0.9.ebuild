# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="Rabbit with a telephone"
HOMEPAGE="https://imoteam.itch.io/hello-girl"
SRC_URI="hello-girl-linux.tar.bz2"
S="${WORKDIR}/hello-girl-linux/"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

RENPY_NO_DECOMPILE=1
RENPY_TITLE="Hello Girl"
