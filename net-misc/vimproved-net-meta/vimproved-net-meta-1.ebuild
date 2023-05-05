# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Metapackage for net related packages"
HOMEPAGE="https://codeberg.org/vimproved"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	|| (
		www-client/firefox-bin
		www-client/firefox
	)
	www-plugins/browserpass
"
