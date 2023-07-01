# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.0.0.9999
#hackport: flags: -pedantic

CABAL_FEATURES="lib profile haddock hoogle hscolour" # test-suite is broken
inherit haskell-cabal

# hololeap (2022-09-25)
# TODO: Tests do not compile due to a change in the directory structure
RESTRICT="test"

DESCRIPTION="Wingman plugin for Haskell Language Server"
HOMEPAGE="https://haskellwingman.dev
	https://github.com/haskell/haskell-language-server/tree/master/plugins/hls-tactics-plugin#readme"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	dev-haskell/aeson:=[profile?]
	>=dev-haskell/extra-1.7.8:=[profile?]
	dev-haskell/fingertree:=[profile?]
	dev-haskell/generic-lens:=[profile?]
	dev-haskell/ghc-exactprint:=[profile?]
	>=dev-haskell/ghc-source-gen-0.4.1:=[profile?] <dev-haskell/ghc-source-gen-0.5:=[profile?]
	~dev-haskell/ghcide-${PV}:=[profile?]
	~dev-haskell/hls-graph-${PV}:=[profile?]
	~dev-haskell/hls-plugin-api-${PV}:=[profile?]
	~dev-haskell/hls-refactor-plugin-${PV}:=[profile?]
	dev-haskell/hyphenation:=[profile?]
	dev-haskell/lens:=[profile?]
	dev-haskell/lsp:=[profile?]
	>=dev-haskell/megaparsec-8:=[profile?] <dev-haskell/megaparsec-10:=[profile?]
	dev-haskell/parser-combinators:=[profile?]
	dev-haskell/prettyprinter:=[profile?]
	>=dev-haskell/refinery-0.4:=[profile?] <dev-haskell/refinery-0.5:=[profile?]
	>=dev-haskell/retrie-0.1.1.0:=[profile?]
	dev-haskell/syb:=[profile?]
	dev-haskell/unagi-chan:=[profile?]
	dev-haskell/unordered-containers:=[profile?]
	>=dev-lang/ghc-8.6.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.4.0.1
"
#	test? (
#		>=dev-haskell/hls-test-utils-1.5 <dev-haskell/hls-test-utils-1.6
#		dev-haskell/hspec
#		dev-haskell/hspec-expectations
#		dev-haskell/lsp-types
#		dev-haskell/quickcheck
#		dev-haskell/tasty-hspec
#		dev-haskell/tasty-hunit
#	)

src_configure() {
	haskell-cabal_src_configure \
		--flag=-pedantic
}

src_test() {
	# Limit tasty threads to avoid random failures
	# See: <https://github.com/haskell/haskell-language-server/issues/3224#issuecomment-1257070277>
	export TASTY_NUM_THREADS=1

	# Enable debug output for the tests
	LSP_TEST_LOG_STDERR=1 \
		LSP_TEST_LOG_MESSAGES=1 \
		haskell-cabal_src_test \
		--test-option=--color=always \
		--test-option=+RTS \
		--test-option=-T
}
