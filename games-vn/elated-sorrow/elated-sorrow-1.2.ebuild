# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="A girls love kinetic novel about two lonely women who meet by chance."
HOMEPAGE="https://foxpancakes.itch.io/elated-sorrow"
SRC_URI="ElatedSorrow-${PV}-pc.zip"
S="${WORKDIR}/ElatedSorrow-${PV}-pc"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_TITLE="Elated Sorrow"
