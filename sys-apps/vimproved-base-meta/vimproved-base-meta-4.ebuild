# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Metapackage for base system packages"
HOMEPAGE="https://codeberg.org/vimproved"

LICENSE="metapackage"
SLOT="0"
IUSE="+portage systemd"
KEYWORDS="~amd64"

RDEPEND="
	app-admin/doas
	app-admin/pass
	app-admin/yadm
	portage? ( app-portage/gentoolkit )
	app-shells/fish
	sys-process/btop
	systemd? ( sys-process/systemd-cron )
"
