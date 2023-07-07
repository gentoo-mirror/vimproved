# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit meson

DESCRIPTION="Chimera's core userland, based on FreeBSD"
HOMEPAGE="https://chimera-linux.org/"
SRC_URI="https://github.com/chimera-linux/chimerautils/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+libedit ncurses +openssl"

DEPEND="
	dev-libs/libxo
	elibc_musl? (
		sys-libs/fts-standalone
		sys-libs/rpmatch-standalone
	)
	libedit? ( dev-libs/libedit )
	ncurses? ( sys-libs/ncurses )
	openssl? ( dev-libs/openssl )
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_feature libedit)
		$(meson_use ncurses color_ls)
		$(meson_feature openssl)
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	# Add -chimera suffix to all coreutils to prevent collisions
	for x in "${ED}/usr/"*"bin/"* ; do
		if [[ -L "${x}" ]] ; then
			ln -sf "$(readlink "${x}")-chimera" "${x}" || die
		fi
		mv "${x}" "${x}-chimera" || die
	done

	for n in "1" "5" "6" "7" "8" ; do
		for x in "${ED}/usr/share/man/man${n}/"* ; do
			if [[ -L "${x}" ]] ; then
				local linkdest=$(readlink "${x}")
				ln -sf "${linkdest%."${n}"}-chimera.${n}" "${x}" || die
			fi
			mv "${x}" "${x%."${n}"}-chimera.${n}" || die
		done
	done
}
