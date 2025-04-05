# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="Claire's got one goal - to spend time with her friend Jamie after school."
HOMEPAGE="https://gg8473.itch.io/walk-in-the-sun"
SRC_URI="WalkintheSun-${PV}-pc.zip"
S="${WORKDIR}/WalkintheSun-1.1-pc"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"

RENPY_WINDOW_ICON="game/window_icon.png"
RENPY_TITLE="walk in the sun"

src_prepare() {
	renpy_src_prepare

	# pretty sure the game version set here is just wrong!
	sed -i "s/1.1/${PV}/" game/options.rpy || die "sed failed"
}
