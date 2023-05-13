# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs xdg-utils

DESCRIPTION="A monitor of resources"
HOMEPAGE="https://github.com/aristocratos/btop"
SRC_URI="https://github.com/aristocratos/btop/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	|| (
		>=sys-devel/gcc-10
		>=sys-devel/clang-16
	)
"

PATCHES=(
	"${FILESDIR}/${P}-allow-clang.patch"
	"${FILESDIR}/${P}-musl-lfs64.patch"

	# Backported fixes for https://bugs.gentoo.org/884005,
	# can be removed in 1.2.14 or later
	"${FILESDIR}/${P}-fix-makefile-deps.patch"
	"${FILESDIR}/${P}-verbose-mkdir.patch"
)

src_prepare() {
	default
	# btop installs README.md to /usr/share/btop by default
	sed -i '/^.*cp -p README.md.*$/d' Makefile || die
}

src_compile() {
	# Disable btop optimization flags, since we have our flags in CXXFLAGS
	emake VERBOSE=true OPTFLAGS="" CXX="$(tc-getCXX)"
}

src_install() {
	emake \
		PREFIX="${EPREFIX}/usr" \
		DESTDIR="${D}" \
		install

	dodoc README.md CHANGELOG.md
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
