# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Metapackage for Wayland programs"
HOMEPAGE="https://codeberg.org/vimproved"

LICENSE="metapackage"
SLOT="0"
IUSE="river sway"
KEYWORDS="~amd64"

RDEPEND="
	gnome-base/gsettings-desktop-schemas
	gui-apps/foot
	gui-apps/fuzzel
	river? ( gui-wm/river )
	sway? ( gui-wm/sway )
"
