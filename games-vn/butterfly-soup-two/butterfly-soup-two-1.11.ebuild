# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="Gay girls playing baseball and falling in love 2"
HOMEPAGE="https://brianna-lei.itch.io/butterfly-soup-2"
SRC_URI="ButterflySoup2-${PV}-linux.tar.bz2"
S="${WORKDIR}/ButterflySoup2-${PV}-linux"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

RENPY_TITLE="Butterfly Soup 2"
