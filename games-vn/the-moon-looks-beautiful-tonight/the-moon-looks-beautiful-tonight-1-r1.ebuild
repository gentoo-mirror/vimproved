# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RENPY_LAYOUT="plain"
inherit renpy

DESCRIPTION="Two girls must travel to the moon's core to fix its broken heart."
HOMEPAGE="https://mokadevs.itch.io/the-moon-looks-beautiful-tonight"
SRC_URI="themoonlooksbeautifultonight-pc.zip"
S="${WORKDIR}/themoonlooksbeautifultonight-pc"

KEYWORDS="~amd64"

BDEPEND+=" app-arch/unzip"

RENPY_TITLE="The Moon Looks Beautiful Tonight"
