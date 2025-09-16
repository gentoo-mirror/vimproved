# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RENPY_OVERRIDE_TITLE="Ad Nauseam - The Wrong Side"
RENPY_USE_PRECOMPILED=1

inherit renpy

DESCRIPTION="Did you wake up on the wrong side?"
HOMEPAGE="https://throwpup.itch.io/throwup-club"
SRC_URI="AdNauseam-${PV}-pc.zip"
S="${WORKDIR}/AdNauseam-${PV}-pc"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

BDEPEND="app-arch/unzip"
