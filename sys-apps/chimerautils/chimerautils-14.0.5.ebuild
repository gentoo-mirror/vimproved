# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Chimera's core userland, based on FreeBSD"
HOMEPAGE="https://chimera-linux.org/"
SRC_URI="https://github.com/chimera-linux/chimerautils/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+libedit ncurses"

DEPEND="
	app-arch/bzip2
	app-arch/xz-utils
	app-arch/zstd
	dev-libs/libedit
	dev-libs/libxo
	dev-libs/openssl
	sys-libs/zlib
	elibc_musl? (
		sys-libs/fts-standalone
		sys-libs/rpmatch-standalone
	)
	ncurses? ( sys-libs/ncurses )
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_feature libedit)
		$(meson_use ncurses color_ls)
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	for bin in "${ED}"/usr/bin/* "${ED}"/usr/sbin/*; do
		if [[ -h "${bin}" ]]; then
			local dest="$(readlink "${bin}")"
			rm "${bin}" || die
			dosym "${dest}-chimera" "${bin#"${ED}"}-chimera"
		else
			mv "${bin}" "${bin}-chimera" || die
		fi
	done

	for man in "${ED}"/usr/share/man/man*/*; do
		local basename_man="${man##*/}"
		local new_man="${man%/*}/${basename_man%%.*}-chimera.${basename_man#*.}"
		if [[ -h "${man}" ]]; then
			local dest="$(readlink "${man}")"
			rm "${man}" || die
			dosym "${dest%%.*}-chimera.${dest#*.}" "${new_man#"${ED}"}"
		else
			mv "${man}" "${new_man}" || die
		fi
	done
}
