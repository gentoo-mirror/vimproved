# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit cmake desktop flag-o-matic git-r3 xdg

DESCRIPTION="A web browser built on the LibWeb and LibJS engines from SerenityOS."
HOMEPAGE="https://serenityos.org/"
EGIT_REPO_URI="https://github.com/serenityos/serenity.git"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""

DEPEND="
	app-arch/brotli
	dev-qt/qtmultimedia:6
	dev-qt/qtsvg:6
	dev-qt/qtwayland:6
	virtual/libcrypt:=
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-qt/qttools
"

S="${S}/Ladybird"

src_prepare() {
	# ld.lld: error: Lagom/Userland/Libraries/LibCompress/CMakeFiles/LibCompress.dir/BrotliDictionary.cpp.o
	# <inline asm>:4:9: Could not find incbin file 'LibCompress/BrotliDictionaryData.bin'
	filter-lto
	cmake_src_prepare
}

src_install() {
	cmake_src_install
	newicon "${WORKDIR}/${P}/Base/res/icons/32x32/app-browser.png" ladybird.png
	make_desktop_entry ladybird Ladybird ladybird Network \
		"Comment=Web browser built from scratch using the SerenityOS LibWeb engine"
}
