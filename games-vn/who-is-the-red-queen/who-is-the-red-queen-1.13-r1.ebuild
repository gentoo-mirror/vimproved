# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="Alice, Alice, the Red Queen is missing."
HOMEPAGE="https://4noki.itch.io/who-is-the-red-queen"
SRC_URI="who-is-the-red-queen-win-linux.zip"
S="${WORKDIR}/WhoIsTheRedQueen-${PV}-pc"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"

PATCHES=(
	"${FILESDIR}/who-is-the-red-queen-1.13-reset-transformations.patch"
)

RENPY_TITLE="Who is the Red Queen?"
