# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Collection of symbols from nerd-fonts."
HOMEPAGE="https://www.nerdfonts.com/"
SRC_URI="https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/NerdFontsSymbolsOnly.tar.xz -> ${P}.tar.xz"
S="${WORKDIR}"

LICENSE="MIT OFL"
SLOT="0"
KEYWORDS="~amd64"

FONT_PN="SymbolsNerdFont"
FONT_SUFFIX="ttf"
