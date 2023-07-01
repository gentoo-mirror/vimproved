# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.0.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Change a declarations type signature with a Code Action"
HOMEPAGE="https://github.com/haskell/haskell-language-server/tree/master/plugins/hls-change-type-signature-plugin#readme"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	~dev-haskell/ghcide-${PV}:=[profile?]
	~dev-haskell/hls-plugin-api-${PV}:=[profile?]
	dev-haskell/lsp-types:=[profile?]
	dev-haskell/regex-tdfa:=[profile?]
	dev-haskell/syb:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	>=dev-lang/ghc-8.6.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.4.0.1
	test? (
		~dev-haskell/hls-test-utils-${PV}
		dev-haskell/lsp
		dev-haskell/quickcheck
	)
"

src_test() {
	# Limit tasty threads to avoid random failures
	# See: <https://github.com/haskell/haskell-language-server/issues/3224#issuecomment-1257070277>
	export TASTY_NUM_THREADS=1
	haskell-cabal_src_test
}
