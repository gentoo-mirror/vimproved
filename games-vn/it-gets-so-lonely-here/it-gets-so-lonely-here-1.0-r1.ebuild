# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit renpy

DESCRIPTION="A yandere yuri visual novel with a fairytale theme."
HOMEPAGE="https://ebihime.itch.io/lonely"
SRC_URI="Itgetssolonelyhere-${PV}-pc.zip"
S="${WORKDIR}/Itgetssolonelyhere-${PV}-pc"

KEYWORDS="~amd64"

BDEPEND+="app-arch/unzip"

RENPY_TITLE="It gets so lonely here"
