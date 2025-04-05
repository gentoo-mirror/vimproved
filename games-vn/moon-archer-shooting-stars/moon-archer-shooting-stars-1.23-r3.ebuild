# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="A gatekeeper of the elevator to the moon meets a girl without papers"
HOMEPAGE="https://4noki.itch.io/moon-archer-shooting-stars"
SRC_URI="moon-archer-shooting-stars-win-linux.zip"
S="${WORKDIR}/MoonArcherShootingStars-${PV}-pc"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"
