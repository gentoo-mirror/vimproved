# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RENPY_LAYOUT="plain"
inherit renpy

DESCRIPTION="A gatekeeper of the elevator to the moon meets a girl without papers"
HOMEPAGE="https://4noki.itch.io/moon-archer-shooting-stars"
SRC_URI="moon-archer-shooting-stars-win-linux.zip"
S="${WORKDIR}/MoonArcherShootingStars-${PV}-pc"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_TITLE="Moon Archer Shooting Stars"
