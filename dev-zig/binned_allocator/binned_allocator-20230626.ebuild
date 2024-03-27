# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit zig-package

DESCRIPTION="A fast, simple allocator for Zig"
HOMEPAGE="https://gist.github.com/antlilja/8372900fcc09e38d7b0b6bbaddad3904"
BINNED_ALLOCATOR_COMMIT="6c3321e0969ff2463f8335da5601986cf2108690"
SRC_URI="https://gist.github.com/antlilja/8372900fcc09e38d7b0b6bbaddad3904/archive/${BINNED_ALLOCATOR_COMMIT}.tar.gz
	-> ${P}.tar.gz"
S="${WORKDIR}/8372900fcc09e38d7b0b6bbaddad3904-${BINNED_ALLOCATOR_COMMIT}"

LICENSE="BSD"
