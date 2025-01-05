# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="A visual novel about gay asian girls playing baseball and falling in love."
HOMEPAGE="https://brianna-lei.itch.io/butterfly-soup"
SRC_URI="ButterflySoup-${PV}-linux.tar.bz2"
S="${WORKDIR}/ButterflySoup-${PV}-linux"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

RENPY_TITLE="Butterfly Soup"
