# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="A lesbian vampire tries to land a date while hustling to pay her rent."
HOMEPAGE="https://ebihime.itch.io/shut-in-vampire"
SRC_URI="ShutInVampire-${PV}-pc.zip"
S="${WORKDIR}/ShutInVampire-${PV}-pc"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_TITLE="Shut-in Vampire"
