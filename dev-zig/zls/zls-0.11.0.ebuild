# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ZIG_MIN="0.11"
ZIG_MAX="0.12"
inherit zig

DESCRIPTION="A Zig language server supporting Zig developers"
HOMEPAGE="https://github.com/zigtools/zls"
BINNED_ALLOCATOR_COMMIT="6c3321e0969ff2463f8335da5601986cf2108690"
DIFFZ_COMMIT="90353d401c59e2ca5ed0abe5444c29ad3d7489aa"
KNOWN_FOLDERS_COMMIT="fa75e1bc672952efa0cf06160bbd942b47f6d59b"
TRACY_COMMIT="37aff70dfa50cf6307b3fee6074d627dc2929143"
SRC_URI="
	https://github.com/zigtools/zls/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://gist.github.com/antlilja/8372900fcc09e38d7b0b6bbaddad3904/archive/${BINNED_ALLOCATOR_COMMIT}.tar.gz
		-> binned_allocator-${BINNED_ALLOCATOR_COMMIT}.tar.gz
	https://github.com/ziglibs/diffz/archive/${DIFFZ_COMMIT}.tar.gz -> diffz-${DIFFZ_COMMIT}.tar.gz
	https://github.com/ziglibs/known-folders/archive/${KNOWN_FOLDERS_COMMIT}.tar.gz
		-> known-folders-${KNOWN_FOLDERS_COMMIT}.tar.gz
	https://github.com/wolfpld/tracy/archive/${TRACY_COMMIT}.tar.gz -> tracy-${TRACY_COMMIT}.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

src_prepare() {
	mkdir -p "${T}/zig-cache/p" || die
	mv "${WORKDIR}/diffz-${DIFFZ_COMMIT}" \
		"${T}/zig-cache/p/122089a8247a693cad53beb161bde6c30f71376cd4298798d45b32740c3581405864" || die
	mv "${WORKDIR}/known-folders-${KNOWN_FOLDERS_COMMIT}" \
		"${T}/zig-cache/p/122048992ca58a78318b6eba4f65c692564be5af3b30fbef50cd4abeda981b2e7fa5" || die
	mv "${WORKDIR}/8372900fcc09e38d7b0b6bbaddad3904-${BINNED_ALLOCATOR_COMMIT}" \
		"${T}/zig-cache/p/1220363c7e27b2d3f39de6ff6e90f9537a0634199860fea237a55ddb1e1717f5d6a5" || die
	rm -r src/tracy || die
	mv "${WORKDIR}/tracy-${TRACY_COMMIT}" src/tracy || die

	default
}
