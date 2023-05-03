# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Metapackage for themes"
HOMEPAGE="https://codeberg.org/vimproved"

LICENSE="metapackage"
SLOT="0"
IUSE="gtk3 gtk4"
KEYWORDS="~amd64"

RDEPEND="
	gtk3? ( x11-themes/adw-gtk3 )
	gtk4? ( gui-apps/gradience )
"
