# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ALTERNATIVES=(
	gpatch:sys-devel/patch
	chimera:sys-apps/chimerautils
)

inherit app-alternatives

DESCRIPTION="/usr/bin/patch symlink"
KEYWORDS="~amd64"

src_install() {
	local suffix=$(get_alternative)
	case "${alt}" in
		gpatch)
			alt="${suffix}"
			;;
		*)
			alt="${PN}-${suffix}"
			;;
	esac

	dosym "${alt}" /usr/bin/patch
	newman - patch.1 <<<".so ${alt}.1"
}
